const std = @import("std");

/// The data retention mode for the account. Valid values are:
///
/// * `default` – The standard data handling for the model applies.
/// * `none` – Zero data retention.
/// * `aws_review` – Amazon Web Services may review the request data. The data
///   is not shared with the model provider. A model must support this mode to
///   be invoked under it.
/// * `provider_data_share` – Data may be shared with the model provider.
/// * `inherit` – No data retention mode is set at this scope.
pub const DataRetentionMode = enum {
    default,
    none,
    aws_review,
    provider_data_share,
    inherit,

    pub const json_field_names = .{
        .default = "default",
        .none = "none",
        .aws_review = "aws_review",
        .provider_data_share = "provider_data_share",
        .inherit = "inherit",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "default",
            .none => "none",
            .aws_review => "aws_review",
            .provider_data_share => "provider_data_share",
            .inherit => "inherit",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
