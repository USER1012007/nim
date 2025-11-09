#include <iostream>

using namespace std;

int main() {

  int tower = 25;

  cout << "Reglas:" << endl;
  cout << "1) empieza con 25 palitos" << endl;
  cout << "2) se alternan los turnos" << endl;
  cout << "3) solo se pueden quitar 1 o 2 palitos p/turno" << endl;
  cout << "4) gana el que quite el ultimo palito" << endl;

  do {
    if (tower < 0) {
      break;
    }
    int player_move;
    cout << "Palitos restantes: " << tower << endl;
    cout << "Tu turno! Cuantos palitos quieres quitar (1 o 2)? " << endl;
    cin >> player_move;

    tower -= player_move;

    cout << "mi turno con: " << tower << endl;
    if (tower % 3 != 0) {
      if (player_move == 2 && tower % 2) {
        tower -= 2;
      } else {
        tower -= 1;
      }
    } else {
      tower -= 1;
    }
  } while (tower != 0);
  printf("gane gg\n");
  return 0;
}
