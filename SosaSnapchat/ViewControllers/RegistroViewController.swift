//
//  RegistroViewController.swift
//  SosaSnapchat
//
//  Created by Anyelina Sosa Hualpa on 29/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistroViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrarTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                      // Asegúrate de que se hayan ingresado ambos campos
                      // Puedes mostrar una alerta aquí si alguno de los campos está vacío
                      return
        }
              
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            print("Intentando crear un usuario")
            if let error = error {
                print("Se presentó el siguiente error al crear el usuario: \(error)")
                // Aquí mostrarías una alerta informando al usuario que el registro falló
            } else {
                print("El usuario fue creado exitosamente")
                guard let user = user else { return }
                Database.database().reference().child("usuarios").child(user.user.uid).child("email").setValue(user.user.email)
                let alerta = UIAlertController(title: "Creación de usuario", message: "Usuario: \(email) se creó correctamente. Por favor inicia sesión.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default) { (UIAlertAction) in
                    // Después del registro exitoso, descarta el controlador actual y vuelve a la vista de inicio de sesión
                    self.dismiss(animated: true, completion: nil)
                }
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
