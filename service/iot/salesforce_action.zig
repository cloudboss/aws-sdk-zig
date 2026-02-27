/// Describes an action to write a message to a Salesforce IoT Cloud Input
/// Stream.
pub const SalesforceAction = struct {
    /// The token used to authenticate access to the Salesforce IoT Cloud Input
    /// Stream. The
    /// token is available from the Salesforce IoT Cloud platform after creation of
    /// the Input
    /// Stream.
    token: []const u8,

    /// The URL exposed by the Salesforce IoT Cloud Input Stream. The URL is
    /// available from
    /// the Salesforce IoT Cloud platform after creation of the Input Stream.
    url: []const u8,

    pub const json_field_names = .{
        .token = "token",
        .url = "url",
    };
};
