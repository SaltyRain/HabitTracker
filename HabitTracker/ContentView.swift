//
//  ContentView.swift
//  HabitTracker
//
//  Created by Regiothek on 14.02.26.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.createdAt, order: .reverse) private var habits: [Habit]

    @State private var isAddSheetPresented = false

    var body: some View {
        NavigationStack {
            List {
                if habits.isEmpty {
                    ContentUnavailableView(
                        "Нет привычек",
                        systemImage: "checklist",
                        description: Text("Нажми +, чтобы добавить первую привычку.")
                    )
                } else {
                    ForEach(habits) { habit in
                        HStack {
                            Text(habit.title)
                            Spacer()
                            Text(habit.createdAt, format: .dateTime.day().month().year())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteHabits)
                }
            }
            .navigationTitle("Привычки")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddSheetPresented) {
                AddHabitView { title in
                    addHabit(title: title)
                }
            }
        }
    }

    private func addHabit(title: String) {
        withAnimation {
            let habit = Habit(title: title)
            modelContext.insert(habit)
        }
    }

    private func deleteHabits(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(habits[index])
            }
        }
    }
}

private struct AddHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""

    let onSave: (String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Название привычки", text: $title)
                    .textInputAutocapitalization(.sentences)
            }
            .navigationTitle("Новая привычка")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        onSave(trimmed)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
