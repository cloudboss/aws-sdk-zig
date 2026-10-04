const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRandomPasswordInput = struct {
    /// A string of the characters that you don't want in the password.
    exclude_characters: ?[]const u8 = null,

    /// Specifies whether to exclude lowercase letters from the password. If you
    /// don't include
    /// this switch, the password can contain lowercase letters.
    exclude_lowercase: ?bool = null,

    /// Specifies whether to exclude numbers from the password. If you don't include
    /// this
    /// switch, the password can contain numbers.
    exclude_numbers: ?bool = null,

    /// Specifies whether to exclude the following punctuation characters from the
    /// password:
    /// `! " # $ % & ' ( ) * + , - . / : ; ? @ [ \ ] ^ _ ` { | }
    /// ~`. If you don't include this switch, the password can contain
    /// punctuation.
    exclude_punctuation: ?bool = null,

    /// Specifies whether to exclude uppercase letters from the password. If you
    /// don't include
    /// this switch, the password can contain uppercase letters.
    exclude_uppercase: ?bool = null,

    /// Specifies whether to include the space character. If you include this
    /// switch, the
    /// password can contain space characters.
    include_space: ?bool = null,

    /// The length of the password. If you don't include this parameter, the default
    /// length is
    /// 32 characters.
    password_length: ?i64 = null,

    /// Specifies whether to include at least one upper and lowercase letter, one
    /// number, and
    /// one punctuation. If you don't include this switch, the password contains at
    /// least one of
    /// every character type.
    require_each_included_type: ?bool = null,

    pub const json_field_names = .{
        .exclude_characters = "ExcludeCharacters",
        .exclude_lowercase = "ExcludeLowercase",
        .exclude_numbers = "ExcludeNumbers",
        .exclude_punctuation = "ExcludePunctuation",
        .exclude_uppercase = "ExcludeUppercase",
        .include_space = "IncludeSpace",
        .password_length = "PasswordLength",
        .require_each_included_type = "RequireEachIncludedType",
    };
};

pub const GetRandomPasswordOutput = struct {
    /// A string with the password.
    random_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .random_password = "RandomPassword",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRandomPasswordInput, options: CallOptions) !GetRandomPasswordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "secretsmanager", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetRandomPasswordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.GetRandomPassword");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRandomPasswordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRandomPasswordOutput, body, allocator);
}
