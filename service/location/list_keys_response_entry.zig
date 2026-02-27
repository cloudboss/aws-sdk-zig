const ApiKeyRestrictions = @import("api_key_restrictions.zig").ApiKeyRestrictions;

/// An API key resource listed in your Amazon Web Services account.
pub const ListKeysResponseEntry = struct {
    /// The timestamp of when the API key was created, in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The optional description for the API key resource.
    description: ?[]const u8,

    /// The timestamp for when the API key resource will expire, in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    expire_time: i64,

    /// The name of the API key resource.
    key_name: []const u8,

    restrictions: ApiKeyRestrictions,

    /// The timestamp of when the API key was last updated, in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .description = "Description",
        .expire_time = "ExpireTime",
        .key_name = "KeyName",
        .restrictions = "Restrictions",
        .update_time = "UpdateTime",
    };
};
