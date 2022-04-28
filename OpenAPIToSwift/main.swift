//
//  main.swift
//  OpenAPIToSwift
//
//  Created by Duncan on 4/27/22.
//

import Foundation
import ArgumentParser

struct Options : ParsableArguments
{
  @Argument(help: "The file path of the OpenAPI specification", completion: .file(extensions: ["yaml", "json"]))
  var filepath : String
}

let options = Options.parseOrExit()

let fileURL = URL(fileURLWithPath: options.filepath)
guard let openAPIData = try? Data(contentsOf: fileURL) else { exit(0) }
let openAPI : OpenAPI
do
{
  openAPI = try JSONDecoder().decode(OpenAPI.self, from: openAPIData)
}
catch
{
  print("Error: \(error)")
  exit(0)
}

print(openAPI.paths.map { $0.key })
