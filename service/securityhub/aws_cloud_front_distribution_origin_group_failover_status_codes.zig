/// The status codes that cause an origin group to fail over.
pub const AwsCloudFrontDistributionOriginGroupFailoverStatusCodes = struct {
    /// The list of status code values that can cause a failover to the next origin.
    items: ?[]const i32 = null,

    /// The number of status codes that can cause a failover.
    quantity: ?i32 = null,

    pub const json_field_names = .{
        .items = "Items",
        .quantity = "Quantity",
    };
};
