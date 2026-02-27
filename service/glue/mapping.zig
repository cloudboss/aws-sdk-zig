/// Specifies the mapping of data property keys.
pub const Mapping = struct {
    /// Only applicable to nested data structures. If you want to change the parent
    /// structure, but also one of its children, you can fill out this data
    /// strucutre. It is also `Mapping`, but its `FromPath` will be the parent's
    /// `FromPath` plus the `FromPath` from this structure.
    ///
    /// For the children part, suppose you have the structure:
    ///
    /// `{
    /// "FromPath": "OuterStructure",
    /// "ToKey": "OuterStructure",
    /// "ToType": "Struct",
    /// "Dropped": false,
    /// "Chidlren": [{
    /// "FromPath": "inner",
    /// "ToKey": "inner",
    /// "ToType": "Double",
    /// "Dropped": false,
    /// }]
    /// }`
    ///
    /// You can specify a `Mapping` that looks like:
    ///
    /// `{
    /// "FromPath": "OuterStructure",
    /// "ToKey": "OuterStructure",
    /// "ToType": "Struct",
    /// "Dropped": false,
    /// "Chidlren": [{
    /// "FromPath": "inner",
    /// "ToKey": "inner",
    /// "ToType": "Double",
    /// "Dropped": false,
    /// }]
    /// }`
    children: ?[]const Mapping,

    /// If true, then the column is removed.
    dropped: ?bool,

    /// The table or column to be modified.
    from_path: ?[]const []const u8,

    /// The type of the data to be modified.
    from_type: ?[]const u8,

    /// After the apply mapping, what the name of the column should be. Can be the
    /// same as `FromPath`.
    to_key: ?[]const u8,

    /// The data type that the data is to be modified to.
    to_type: ?[]const u8,

    pub const json_field_names = .{
        .children = "Children",
        .dropped = "Dropped",
        .from_path = "FromPath",
        .from_type = "FromType",
        .to_key = "ToKey",
        .to_type = "ToType",
    };
};
