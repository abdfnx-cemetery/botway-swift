import Foundation

struct BW: Codable {
    let botway: Botway
}

struct Botway: Codable {
    let bots: Bots
    let botsNames: [String]

    enum CodingKeys: String, CodingKey {
        case bots
        case botsNames = "bots_names"
    }
}

struct Bots: Codable {
    let {{.BotName}}: {{.BotName}}
}

struct {{.BotName}}: Codable {
    let type, path, lang, botToken, signingSecret: String
    let botAppID: String?

    enum CodingKeys: String, CodingKey {
        case type, path, lang
        case botToken = "bot_token"
        case signingSecret = "signing_secret"

        if (type == "slack") {
            case botAppID = "bot_app_token"
        } else {
            case botAppID = "bot_app_id"
        }
    }
}

let botwayConfigPath = NSString(string: NSHomeDirectory())
    .appendingPathComponent(NSString(string: ".botway")
    .appendingPathComponent(NSString(string: "botway.json")
    as String
))

let config = try? Data(contentsOf: URL(fileURLWithPath: botwayConfigPath))
let botwayConfig = try? JSONDecoder().decode(BW.self, from: config!)

func GetToken() -> String {
    return botwayConfig!.botway.bots.{{.BotName}}.botToken
}

func GetAppId() -> String {
    return botwayConfig!.botway.bots.{{.BotName}}.botAppID!
}

func GetSigningSecret() -> String {
    return botwayConfig!.botway.bots.{{.BotName}}.signingSecret
}
