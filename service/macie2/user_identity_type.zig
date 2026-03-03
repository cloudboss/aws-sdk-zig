const std = @import("std");

/// The type of entity that performed the action on the affected resource.
/// Possible values are:
pub const UserIdentityType = enum {
    assumed_role,
    iam_user,
    federated_user,
    root,
    aws_account,
    aws_service,

    pub const json_field_names = .{
        .assumed_role = "AssumedRole",
        .iam_user = "IAMUser",
        .federated_user = "FederatedUser",
        .root = "Root",
        .aws_account = "AWSAccount",
        .aws_service = "AWSService",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assumed_role => "AssumedRole",
            .iam_user => "IAMUser",
            .federated_user => "FederatedUser",
            .root => "Root",
            .aws_account => "AWSAccount",
            .aws_service => "AWSService",
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
