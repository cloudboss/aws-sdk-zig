/// The matching criteria to be used during the auto-merging process.
pub const Consolidation = struct {
    /// A list of matching criteria.
    matching_attributes_list: []const []const []const u8,

    pub const json_field_names = .{
        .matching_attributes_list = "MatchingAttributesList",
    };
};
