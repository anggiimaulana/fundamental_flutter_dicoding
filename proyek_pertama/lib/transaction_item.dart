class TransactionItem {
  final String title;
  final String subtitle;
  final String image;
  final String money;

  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.money,
  });
}

const List<TransactionItem> transactionItemList = [
  TransactionItem(
    title: 'Burger Stand',
    subtitle: 'Tue. July 4th, 3:42pm',
    image: 'https://loremflickr.com/1280/720/food',
    money: '\$8.20',
  ),
  TransactionItem(
    title: 'Veggie Opulous',
    subtitle: 'Tue. July 4th, 10:48pm',
    image: 'https://loremflickr.com/1280/720/food',
    money: '\$14.82',
  ),
  TransactionItem(
    title: 'PizzaBoy',
    subtitle: 'Mon. July 3th, 2:20pm',
    image: 'https://loremflickr.com/1280/720/food',
    money: '\$124.00',
  ),
  TransactionItem(
    title: 'Burger Stand',
    subtitle: 'Mon. July 3th, 12:20pm',
    image: 'https://loremflickr.com/1280/720/food',
    money: '\$21.50',
  ),
];
