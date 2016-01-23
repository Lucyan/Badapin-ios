//
//  HomeController.swift
//  Badapin
//
//  Created by Leonardo Olivares on 22-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit
import PullToRefresh
import SDWebImage
import SwiftCharts

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewList: UITableView!
    
    var stream_id : String?
    var selected_row : NSIndexPath?
    var loadingStream = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Badapin"
        
        let refresher = PullToRefresh()
        
        tableViewList.addPullToRefresh(refresher, action: {
            self.loadStream(true)
            
            self.tableViewList.endRefreshing()
        })
    }
    
    func loadStream(getNews: Bool) {
        if self.loadingStream {
            //print("load more")
            self.loadingStream = false
            streamMng.fetch(getNews) {
                () in
                self.tableViewList.reloadData()
                
                self.loadingStream = true
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadStream(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamMng.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : CustomCell = tableViewList.dequeueReusableCellWithIdentifier("customcell") as! CustomCell
        
        cell.nick.text = streamMng.list[indexPath.row].nick
        cell.descript.text = streamMng.list[indexPath.row].descripcion
        
        cell.avatar.sd_setImageWithURL(NSURL(string: streamMng.list[indexPath.row].avatar_url), placeholderImage: UIImage(named: "perfil"))
        cell.imagen.sd_setImageWithURL(NSURL(string: streamMng.list[indexPath.row].imagen_url), placeholderImage: UIImage(named: "foto_icon"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("select tab:\(indexPath.row)")
        
        let cell : CustomCell = tableViewList.cellForRowAtIndexPath(indexPath) as! CustomCell
        
        if (cell.votado == false) {
            cell.resultadoView.frame.origin.x = cell.votarView.frame.size.width
        }
        
        self.stream_id = streamMng.list[indexPath.row].stream_id
        self.selected_row = indexPath
        
        if (cell.votacionView.alpha == 0.0) {
            streamMng.checkVotacion(self.stream_id!) {
                (flag) in
                if (flag == false) {
                    streamMng.getVotacion(self.stream_id!) {
                        (flag, resp) in
                        if (flag) {
                            self.printVotacion(false, resp: resp)
                        }
                    }
                }
            }
            
            UIView.animateWithDuration(0.3, animations: {
                cell.votacionView.alpha = 1.0
            })
        } else {
            UIView.animateWithDuration(0.3, animations: {
                cell.votacionView.alpha = 0.0
                }) {
                    flag in
                    cell.votarView.frame.origin.x = 0
                    cell.resultadoView.frame.origin.x = cell.resultadoView.frame.size.width
            }
        }
        
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row > 5) {
            if (indexPath.row == (streamMng.list.count - 2)) {
                self.loadStream(false)
            }
        }
        
    }
    
    @IBAction func votar(sender: UIButton) {
        streamMng.votar(sender.tag, stream_id: self.stream_id!)  {
            (resp) in
            
            self.printVotacion(true, resp: resp)
        }
    }
    
    func printVotacion(animated: Bool, resp: JSON) {
        let cell : CustomCell = self.tableViewList.cellForRowAtIndexPath(self.selected_row!) as! CustomCell
        
        cell.votado = true
        
//        for (_, votacion):(String, JSON) in resp {
//            if let palabra = votacion["palabra"].string {
//                if let num = votacion["votos"].number {
//                    switch (palabra) {
//                    case "Aburrido":
//                        cell.lblAburrido.text = num.stringValue
//                    case "Ego":
//                        cell.lvlEgo.text = num.stringValue
//                    case "Estilo":
//                        cell.lvlEstilo.text = num.stringValue
//                    case "Sexo":
//                        cell.lvlSexo.text = num.stringValue
//                    case "Amor":
//                        cell.lvlAmor.text = num.stringValue
//                    case "Belleza":
//                        cell.lvlBelleza.text = num.stringValue
//                    case "Freak":
//                        cell.lvlFreak.text = num.stringValue
//                    case "Fuerza":
//                        cell.lvlFuerza.text = num.stringValue
//                    case "Salvaje":
//                        cell.lvlSalvaje.text = num.stringValue
//                    case "Gracioso":
//                        cell.lvlGracioso.text = num.stringValue
//                    default:
//                        print("default")
//                    }
//                }
//            }
//        }
        
        for view in cell.chartView.subviews{
            view.removeFromSuperview()
        }
        
        if let opcion1 = resp[0, "palabra"].string {
            if let total1 = resp[0, "votos"].number {
                if let masculino1 = resp[0, "masculino"].number {
                    if let femenino1 = resp[0, "femenino"].number {
                        
                        if let opcion2 = resp[1, "palabra"].string {
                            if let total2 = resp[1, "votos"].number {
                                if let masculino2 = resp[1, "masculino"].number {
                                    if let femenino2 = resp[1, "femenino"].number {
                                        
                                        if let opcion3 = resp[2, "palabra"].string {
                                            if let total3 = resp[2, "votos"].number {
                                                if let masculino3 = resp[2, "masculino"].number {
                                                    if let femenino3 = resp[2, "femenino"].number {
                                                        
                                                        //                                                        let chartConfig = BarsChartConfig(
                                                        //                                                            valsAxisConfig: ChartAxisConfig(from: 0, to: total1.doubleValue, by: 1),
                                                        //                                                            xAxisLabelSettings: ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFontOfSize(11)),
                                                        //                                                            yAxisLabelSettings: ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFontOfSize(11))
                                                        //                                                        )
                                                        //
                                                        //                                                        let chart = BarsChart(
                                                        //                                                            frame: cell.chartView.bounds,
                                                        //                                                            chartConfig: chartConfig,
                                                        //                                                            xTitle: "Palabras",
                                                        //                                                            yTitle: "Votos",
                                                        //                                                            bars: [
                                                        //                                                                (opcion1, total1.doubleValue),
                                                        //                                                                (opcion2, total2.doubleValue),
                                                        //                                                                (opcion3, total3.doubleValue)
                                                        //                                                            ],
                                                        //                                                            color: UIColor.redColor(),
                                                        //                                                            barWidth: 20,
                                                        //                                                            horizontal: true
                                                        //                                                        )
                                                        
                                                        let chart = self.stackedBarsChart([
                                                            (opcion1, [
                                                                (0, masculino1.doubleValue),
                                                                (0, femenino1.doubleValue)
                                                                ]),
                                                            (opcion2, [
                                                                (0, masculino2.doubleValue),
                                                                (0, femenino2.doubleValue)
                                                                ]),
                                                            (opcion3, [
                                                                (0, masculino3.doubleValue),
                                                                (0, femenino3.doubleValue)
                                                                ])
                                                            ], total: total1.doubleValue, frame: cell.chartView.bounds, horizontal: true)
                                                        
                                                        cell.chartView.addSubview(chart.view)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
            }
        }
        
        
        if (animated) {
            UIView.animateWithDuration(0.5, animations: {
                cell.resultadoView.frame.origin.x = 0
                cell.votarView.frame.origin.x = cell.votarView.frame.size.width * -1
            })
        } else {
            cell.resultadoView.frame.origin.x = 0
            cell.votarView.frame.origin.x = cell.votarView.frame.size.width * -1
        }
    }
    
    private func barsChart(groupsData: [(title: String, [(min: Double, max: Double)])], total: Double, frame: CGRect, horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFontOfSize(11), fontColor: UIColor.whiteColor())
        
        let chartSettings = ChartSettings()
        chartSettings.leading = 0
        chartSettings.top = 0
        chartSettings.trailing = 0
        chartSettings.bottom = 0
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        
        let groupColors = [UIColor.cyanColor().colorWithAlphaComponent(0.6), UIColor.magentaColor().colorWithAlphaComponent(0.6), UIColor.greenColor().colorWithAlphaComponent(0.6)]
        
        let groups: [ChartPointsBarGroup] = groupsData.enumerate().map {index, entry in
            let constant = ChartAxisValueDouble(index)
            let bars = entry.1.enumerate().map {index, tuple in
                ChartBarModel(constant: constant, axisValue1: ChartAxisValueDouble(tuple.min), axisValue2: ChartAxisValueDouble(tuple.max), bgColor: groupColors[index])
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
        let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            0.stride(through: total, by: 1).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerate().map {index, tuple in print(tuple); return ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        let chartFrame = frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let groupsLayer = ChartGroupedPlainBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, groups: groups, horizontal: horizontal, barSpacing: 2, groupSpacing: 25, animDuration: 0.5)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 0.1)
        let guidelinesLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: horizontal ? .X : .Y, settings: settings)
        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                groupsLayer
            ]
        )
    }
    
    private func stackedBarsChart(groupsData: [(title: String, [(min: Double, max: Double)])], total: Double, frame: CGRect, horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFontOfSize(12), fontColor: UIColor.redColor())
        
        let chartSettings = ChartSettings()
        chartSettings.leading = 0
        chartSettings.top = 10
        chartSettings.trailing = 0
        chartSettings.bottom = 0
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 10
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        
        let groupColors = [UIColor.cyanColor().colorWithAlphaComponent(0.6), UIColor.magentaColor().colorWithAlphaComponent(0.6)]
        let zero = ChartAxisValueDouble(0)
        let barModels: [ChartStackedBarModel] = groupsData.enumerate().map {index, entry in
            let bars = entry.1.enumerate().map {index, tuple in
                ChartStackedBarItemModel(quantity: tuple.max, bgColor: groupColors[index])
            }
            return ChartStackedBarModel(constant: ChartAxisValueString(entry.title, order: index + 1, labelSettings: labelSettings), start: zero, items: bars)
        }
    
        
        let (axisValues1, axisValues2) = (
            0.stride(through: total, by: 1).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: groupsData.count, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Palabras", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Votaciones", settings: labelSettings.defaultVertical()))
        let chartFrame = frame
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 20, animDuration: 0.5)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 0.1)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
}