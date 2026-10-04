const std = @import("std");

/// The primary use case for the domain, which determines the default
/// configuration and the
/// engine modes that are available. Valid values are `SEARCH` (full-text
/// search,
/// e-commerce, content discovery, and hybrid and semantic search), `VECTOR`
/// (k-NN
/// and semantic search, and retrieval-augmented generation), `OBSERVABILITY`
/// (logs,
/// metrics, traces, and dashboards), and `MIXED` (a combination of search and
/// analytics). If you don't specify a use case, `MIXED` is used.
pub const DomainUseCase = enum {
    search,
    vector,
    observability,
    mixed,

    pub const json_field_names = .{
        .search = "SEARCH",
        .vector = "VECTOR",
        .observability = "OBSERVABILITY",
        .mixed = "MIXED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .search => "SEARCH",
            .vector => "VECTOR",
            .observability => "OBSERVABILITY",
            .mixed => "MIXED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
