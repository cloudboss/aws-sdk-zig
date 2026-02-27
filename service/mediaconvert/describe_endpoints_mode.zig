/// Optional field, defaults to DEFAULT. Specify DEFAULT for this operation to
/// return your endpoints if any exist, or to create an endpoint for you and
/// return it if one doesn't already exist. Specify GET_ONLY to return your
/// endpoints if any exist, or an empty list if none exist.
pub const DescribeEndpointsMode = enum {
    default,
    get_only,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .get_only = "GET_ONLY",
    };
};
