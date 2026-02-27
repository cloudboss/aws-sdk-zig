const MembershipAccountRelationshipStatus = @import("membership_account_relationship_status.zig").MembershipAccountRelationshipStatus;
const MembershipAccountRelationshipType = @import("membership_account_relationship_type.zig").MembershipAccountRelationshipType;

pub const GetMembershipAccountDetailItem = struct {
    account_id: ?[]const u8,

    relationship_status: ?MembershipAccountRelationshipStatus,

    relationship_type: ?MembershipAccountRelationshipType,

    pub const json_field_names = .{
        .account_id = "accountId",
        .relationship_status = "relationshipStatus",
        .relationship_type = "relationshipType",
    };
};
