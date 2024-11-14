import 'package:flutter/material.dart';

class Income {
  double amount;
  DateTime date;

  Income({required this.amount, required this.date});
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _amountController = TextEditingController();
  List<Income> _incomes = [];
  double _totalIncome = 0.0;

  @override
  void initState() {
    super.initState();
    _loadIncomes();
  }

  void _loadIncomes() {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    List<Income> filteredIncomes = _incomes.where((income) {
      return income.date.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
             income.date.isBefore(endOfMonth.add(Duration(days: 1)));
    }).toList();

    double total = filteredIncomes.fold(0.0, (sum, income) => sum + income.amount);

    setState(() {
      _incomes = filteredIncomes;
      _totalIncome = total;
    });
  }

  void _addIncome() {
    if (_amountController.text.isEmpty) return;
    double amount = double.tryParse(_amountController.text) ?? 0;

    if (amount > 0) {
      Income income = Income(amount: amount, date: DateTime.now());
      setState(() {
        _incomes.add(income);
      });
      _amountController.clear();
      _loadIncomes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(  // Menambahkan SafeArea di sini untuk menghindari elemen layar tertutup
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.cyan),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Jumlah Pemasukan',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Mengubah warna outline saat fokus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Mengubah warna outline saat tidak fokus
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addIncome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB9E5E8),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Tambah Pemasukan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total Pemasukan: \$${_totalIncome.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _incomes.length,
                  itemBuilder: (context, index) {
                    Income income = _incomes[index];
                    return Card(
                      elevation: 4,
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          '\$${income.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          '${income.date.day}-${income.date.month}-${income.date.year}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
