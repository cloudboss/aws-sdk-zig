/// Configure a Snowflake VPC
pub const SnowflakeVpcConfiguration = struct {
    /// The VPCE ID for Firehose to privately connect with Snowflake. The ID format
    /// is
    /// com.amazonaws.vpce.[region].vpce-svc-. For more information, see [Amazon
    /// PrivateLink &
    /// Snowflake](https://docs.snowflake.com/en/user-guide/admin-security-privatelink)
    private_link_vpce_id: []const u8,

    pub const json_field_names = .{
        .private_link_vpce_id = "PrivateLinkVpceId",
    };
};
