//
//  CurrencyViewController.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import UIKit

class CurrencyViewController: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomGradientView: GradientView!
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    private var presenter: CurrencyPresentation!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.onViewDidLoad()
    }
    
    // MARK: Public methods
    
    func set(_ presenter: CurrencyPresentation) {
        self.presenter = presenter
    }
    
    // MARK: Private methods
    
    private func configure() {
        configureCollectionView()
        bottomGradientView.locations = [0, 0.6]
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: PriceCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
    }
}

// MARK: PriceListView

extension CurrencyViewController: CurrencyInterface {
    func setCollectionView(provider: CurrencyCollectionViewProvider) {
        collectionView.collectionViewLayout = getCollectionViewLayout()
        collectionView.delegate = provider
        collectionView.dataSource = provider
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: CollectionViewLayout

extension CurrencyViewController {
    private func getCollectionViewLayout() -> UICollectionViewLayout {
        let itemsVerticalSpace: CGFloat = 0
        let itemsHorizontalSpace: CGFloat = 32.0
        let sideSpace: CGFloat = 0
        let cellWidth: CGFloat = view.frame.width - 24.0
        let cellHeight: CGFloat = 41.0
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: sideSpace, bottom: 0, right: sideSpace)
        layout.minimumInteritemSpacing = itemsVerticalSpace
        layout.minimumLineSpacing = itemsHorizontalSpace
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return layout
    }
}
