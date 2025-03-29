class RequestItem {
  final String title;
  final String image;
  final String money;

  const RequestItem({
    required this.title,
    required this.image,
    required this.money,
  });
}

const List<RequestItem> requestItemList = [
  RequestItem(
    title: 'Receive Funds',
    image: 'https://loremflickr.com/1280/720',
    money: '\$50.00',
  ),
  RequestItem(
    title: 'Pay Now',
    image: 'https://loremflickr.com/1280/720',
    money: '\$210.00',
  ),
  RequestItem(
    title: 'Receive Funds',
    image: 'https://loremflickr.com/1280/720',
    money: '\$4.50',
  ),
];
