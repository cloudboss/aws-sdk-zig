/// The filter applied to `ListProfileObjects` response to include profile
/// objects with the specified index values.
pub const ObjectFilter = struct {
    /// A searchable identifier of a profile object. The predefined keys you can use
    /// to search
    /// for `_asset` include: `_assetId`, `_assetName`, and
    /// `_serialNumber`. The predefined keys you can use to search for
    /// `_case` include: `_caseId`. The predefined keys you can use to
    /// search for `_order` include: `_orderId`.
    key_name: []const u8,

    /// A list of key values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key_name = "KeyName",
        .values = "Values",
    };
};
