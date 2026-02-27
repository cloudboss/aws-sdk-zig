/// Inspect one query argument in the web request, identified by name, for
/// example
/// *UserName* or *SalesRegion*. The name isn't case
/// sensitive.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
///
/// Example JSON: `"SingleQueryArgument": { "Name": "myArgument" }`
pub const SingleQueryArgument = struct {
    /// The name of the query argument to inspect.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
