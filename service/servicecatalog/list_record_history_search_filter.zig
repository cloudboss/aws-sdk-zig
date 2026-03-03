/// The search filter to use when listing history records.
pub const ListRecordHistorySearchFilter = struct {
    /// The filter key.
    ///
    /// * `product` - Filter results based on the specified product identifier.
    ///
    /// * `provisionedproduct` - Filter results based on the provisioned product
    ///   identifier.
    key: ?[]const u8 = null,

    /// The filter value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
