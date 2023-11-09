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
        return SimpleDialog(
          title: Text('Winner!'),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('$winner is the winner!'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void showTieDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('GAME OVER!'),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('NO ONE WINNES '),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
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
        title: Center(child: const Text('Tic Tac Toe')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
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
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Turn'),
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () => Icon(Icons.one_x_mobiledata),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {},
                child: Text('Player X'),
              ),
              FilledButton(
                onPressed: () {},
                child: Text('Player O'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
