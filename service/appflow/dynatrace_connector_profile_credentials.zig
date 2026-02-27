/// The connector-specific profile credentials required by Dynatrace.
pub const DynatraceConnectorProfileCredentials = struct {
    /// The API tokens used by Dynatrace API to authenticate various API calls.
    api_token: []const u8,

    pub const json_field_names = .{
        .api_token = "apiToken",
    };
};
