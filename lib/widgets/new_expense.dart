import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSubmitExpense});

  final void Function(Expense expense) onSubmitExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitNewExpense() {
    final amount = double.tryParse(_amountController.text);
    final title = _titleController.text.trim();

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure you entered a valid title, amount and date'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay')),
          ],
        ),
      );
      return;
    }
    widget.onSubmitExpense(Expense(
        amount: amount,
        date: _selectedDate!,
        title: title,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    Widget titleInput = TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );

    Widget amountInput = TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
      ),
    );

    Widget dateInput = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_selectedDate == null
            ? 'No date selected'
            : dateFormatter.format(_selectedDate!)),
        const SizedBox(width: 4),
        IconButton(
          onPressed: _openDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );

    Widget categoryDropdown = DropdownButton(
        value: _selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedCategory = value;
            });
          }
        });

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final availableWidth = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardHeight + 16),
              child: Column(
                children: [
                  availableWidth >= 600
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: titleInput),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(child: amountInput)
                          ],
                        )
                      : titleInput,
                  Row(
                    children: [
                      Expanded(
                        child: availableWidth >= 600
                            ? categoryDropdown
                            : amountInput,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: dateInput,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (availableWidth < 600) categoryDropdown,
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: _submitNewExpense,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
