const Query = @import("query.zig").Query;

pub const QueriesConfig = struct {
    queries: []const Query,

    pub const json_field_names = .{
        .queries = "Queries",
    };
};
