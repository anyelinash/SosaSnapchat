//
//  ViewController.swift
//  SosaSnapchat
//
//  Created by Anyelina Sosa Hualpa on 20/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Asegúrate de que se hayan ingresado ambos campos
            // Puedes mostrar una alerta aquí si alguno de los campos está vacío
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            print("Intentando Iniciar Sesion")
            if let error = error {
                self.mostrarAlertaUsuarioNoCreado()
                
                return
            } else {
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    func mostrarAlertaUsuarioNoCreado() {
           let alerta = UIAlertController(title: "Usuario no registrado", message: "El usuario no está registrado. ¿Deseas crear una cuenta?", preferredStyle: .alert)
           let crearCuentaAction = UIAlertAction(title: "Crear", style: .default) { _ in
               self.performSegue(withIdentifier: "registroSegue", sender: nil)
           }
           let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
           alerta.addAction(crearCuentaAction)
           alerta.addAction(cancelarAction)
           present(alerta, animated: true, completion: nil)
       }
}

