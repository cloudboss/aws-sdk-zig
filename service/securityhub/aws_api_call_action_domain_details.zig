/// Provided if `CallerType` is `domain`. It provides information
/// about the DNS domain that issued the API call.
pub const AwsApiCallActionDomainDetails = struct {
    /// The name of the DNS domain that issued the API call.
    ///
    /// Length Constraints: 128.
    domain: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};
