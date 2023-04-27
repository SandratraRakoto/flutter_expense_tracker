import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({
    super.key,
  });

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 16.59,
      date: DateTime.now(),
      title: 'Flutter course',
      category: Category.work,
    ),
    Expense(
      amount: 19.99,
      date: DateTime.now(),
      title: 'Cinema',
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onSubmitExpense: _insertNewExpense),
    );
  }

  void _insertNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: screenWidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: _registeredExpenses.isNotEmpty
                      ? ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense)
                      : const Center(
                          child: Text('No expense registered yet'),
                        ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: _registeredExpenses.isNotEmpty
                      ? ExpensesList(
                          expenses: _registeredExpenses,
                          onRemoveExpense: _removeExpense)
                      : const Center(
                          child: Text('No expense registered yet'),
                        ),
                ),
              ],
            ),
    );
  }
}
