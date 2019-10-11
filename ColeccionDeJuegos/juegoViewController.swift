//
//  juegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by yenifer santiago  on 10/10/19.
//  Copyright © 2019 yenifer santiago . All rights reserved.
//

import UIKit

class juegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var juego:Juego? = nil
    
    @IBOutlet weak var juegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarBoton: UIButton!

    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if juego != nil{
            juegoImageView.image = UIImage(data:(juego!.imagen!)as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }
        else{
            eliminarBoton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[UIImagePickerController.InfoKey.originalImage] as!   UIImage
        juegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    @IBAction func agregarTapped(_ sender: Any) {
        
        if  juego != nil{
            juego!.titulo = tituloTextField.text
            juego!.imagen = juegoImageView.image!.pngData() as NSData? as Data?
        }
        else{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text
        juego.imagen = juegoImageView.image!.pngData()as NSData? as Data?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true) 
    }

    @IBAction func eliminarTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
}
