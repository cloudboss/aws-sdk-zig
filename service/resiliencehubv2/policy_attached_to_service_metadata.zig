/// Contains details about the service that started using the policy, such as
/// the account that owns the service.
pub const PolicyAttachedToServiceMetadata = struct {
    /// The account that owns the service.
    account_id: ?[]const u8 = null,

    service_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .service_arn = "serviceArn",
    };
};
