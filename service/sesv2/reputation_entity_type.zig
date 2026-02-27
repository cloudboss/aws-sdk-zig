/// The type of reputation entity. Currently, only `RESOURCE` type entities are
/// supported,
/// which represent resources in your Amazon SES account that have reputation
/// tracking capabilities.
pub const ReputationEntityType = enum {
    resource,

    pub const json_field_names = .{
        .resource = "RESOURCE",
    };
};
