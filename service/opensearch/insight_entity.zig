const InsightEntityType = @import("insight_entity_type.zig").InsightEntityType;

/// Specifies the entity for which to retrieve insights. An entity can be an
/// Amazon
/// OpenSearch Service domain or an Amazon Web Services account.
pub const InsightEntity = struct {
    /// The type of the entity. Possible values are `Account` and
    /// `DomainName`.
    @"type": InsightEntityType,

    /// The value of the entity. For `DomainName`, this is the domain name. For
    /// `Account`, this is the Amazon Web Services account ID.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
