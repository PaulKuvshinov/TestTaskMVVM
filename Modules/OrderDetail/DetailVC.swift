//
//  DetailVC.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import UIKit

final class DetailVC: UIViewController {
    
    private let carImage = UIImageView()
    private let timeLabel = UILabel(font: .helvetica14Light())
    private let orderTimeLabel = LabelWithLine(font: .helvetica17())
    private let modelNameLabel = LabelWithLine(font: .helvetica17())
    private let regNumberLabel = LabelWithLine(font: .helvetica17())
    private let driverNameLabel = LabelWithLine(font: .helvetica17())
    private let activityIndicator = UIActivityIndicatorView()
    
    weak var viewModel: DetailVCViewModelProtocol? {
        didSet {
            if viewModel?.order != nil {
                guard let id = viewModel?.id else {
                    showAllert(error: NetworkError.incorrectData); return
                }
                setupViewElements()
                viewModel?.imageManager.getImageData(id: id, complition: { [weak self] data in
                    guard let self = self else { return }
                    self.carImage.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                    guard self.carImage.image != nil else {
                        self.showAllert(error: NetworkError.incorrectData); return
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        title = "Order detail"
        carImage.layer.cornerRadius = 8
        carImage.clipsToBounds = true
        carImage.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupViewElements() {
        guard let unwrapViewModelOrder = viewModel?.order else {
            return
        }
        let dateFortmater = DateFormatter()
        dateFortmater.dateFormat = "E, d MMM yyyy HH:mm"
        timeLabel.text = "Info"
        modelNameLabel.text = "Car: " + (unwrapViewModelOrder.vehicle.modelName)
        regNumberLabel.text = "Register number: " + (unwrapViewModelOrder.vehicle.regNumber)
        driverNameLabel.text = "Driver name: " + (unwrapViewModelOrder.vehicle.driverName)
        orderTimeLabel.text = "Order time: " + dateFortmater.string(from: unwrapViewModelOrder.orderTime)
    }
    
    private func setupConstraints() {
        let grayView = UIView()
        grayView.backgroundColor = .secondarySystemBackground
        grayView.layer.cornerRadius = 8
        grayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(grayView)
        carImage.addSubview(activityIndicator)
        let infoStackView = UIStackView(arrangedSubviews: [
            timeLabel,
            orderTimeLabel,
            modelNameLabel,
            regNumberLabel,
            driverNameLabel], axis: .vertical, spacing: 10)
        
        grayView.addSubview(infoStackView)
        grayView.addSubview(carImage)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        carImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            grayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            grayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            grayView.bottomAnchor.constraint(equalTo: carImage.bottomAnchor, constant: 20),
            
            infoStackView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -10),
            infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: grayView.bottomAnchor, constant: -100),
            
            carImage.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 10),
            carImage.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 15),
            carImage.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -18),
            carImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.29),
            
            activityIndicator.centerXAnchor.constraint(equalTo: carImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: carImage.centerYAnchor)
        ])
    }
    
    private func showAllert(error: Error) {
        let allertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        allertController.addAction(UIAlertAction.init(title: "Try again", style: .default))
        present(allertController, animated: true, completion: nil)
    }
    
}
