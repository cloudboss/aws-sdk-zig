const MembershipStatus = @import("membership_status.zig").MembershipStatus;
const AwsRegion = @import("aws_region.zig").AwsRegion;

pub const ListMembershipItem = struct {
    account_id: ?[]const u8,

    membership_arn: ?[]const u8,

    membership_id: []const u8,

    membership_status: ?MembershipStatus,

    region: ?AwsRegion,

    pub const json_field_names = .{
        .account_id = "accountId",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .membership_status = "membershipStatus",
        .region = "region",
    };
};
