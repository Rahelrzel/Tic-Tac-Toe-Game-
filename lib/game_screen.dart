import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<String>> board =
      List.generate(3, (i) => List.generate(3, (j) => ''));

  bool ispalyerX = true;
  void _onTapped(int col, int row) {
    if (board[col][row] == '') {
      setState(() {
        board[col][row] = ispalyerX ? 'X' : 'O';
        ispalyerX = !ispalyerX;

        String? winner = checkForWinner();

        if (winner != null) {
          showWinnerDialog(winner);
        } else if (isGameOver()) {
          showTieDialog();
        }
      });
    }
  }

  bool isGameOver() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              winner,
              style: TextStyle(
                  fontSize: 90, color: Color.fromARGB(255, 218, 116, 236)),
            ),
          ),
          content: SizedBox(
            height: 25,
            child: Column(
              children: [
                Text(
                  'Player $winner Won!!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 208, 58, 235))),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.replay,
                      color: Colors.black,
                    ),
                    Text(
                      'Play Again',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
          backgroundColor: Colors.black.withOpacity(0.4),
        );
      },
    );
  }

  void showTieDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Icon(Icons.shape_line_outlined,
              size: 70, color: Color.fromARGB(255, 202, 94, 221)),
          content: SizedBox(
            height: 20,
            child: Column(
              children: [
                Text(
                  'It\'s a Draw',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.replay,
                    color: Colors.black,
                  ),
                  Text('Play Again'),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.black.withOpacity(0.2),
        );
      },
    );
  }

  String? checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '') {
        return board[i][0];
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '') {
        return board[0][i];
      }
    }

    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != '') {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != '') {
      return board[0][2];
    }

    return null;
  }

  void resetGame() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          board[i][j] = '';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tic Tac Toe')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 125),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        _onTapped(row, col);
                        print('Row: $row, Column: $col');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        height: 3,
                        width: 3,
                        child: Center(
                          child: Text(
                            board[row][col],
                            style: const TextStyle(
                                fontSize: 80,
                                color: Color.fromARGB(255, 232, 138, 248)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Turn'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: ispalyerX
                ? [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 20)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 218, 127, 235)),
                      ),
                      child: Text('Player X'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 20)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text('Player O'),
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 20)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text('Player X'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 20)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 218, 127, 235)),
                      ),
                      child: Text('Player O'),
                    ),
                  ],
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
