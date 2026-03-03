const aws = @import("aws");

const GroupScope = @import("group_scope.zig").GroupScope;
const GroupType = @import("group_type.zig").GroupType;
const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// A group object that contains identifying information and attributes for a
/// specified
/// group.
pub const Group = struct {
    /// The [distinguished
    /// name](https://learn.microsoft.com/en-us/windows/win32/ad/object-names-and-identities#distinguished-name) of the object.
    distinguished_name: ?[]const u8 = null,

    /// The scope of the AD group. For details, see [Active Directory security
    /// groups](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope)
    group_scope: ?GroupScope = null,

    /// The AD group type. For details, see [Active Directory security group
    /// type](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#how-active-directory-security-groups-work).
    group_type: ?GroupType = null,

    /// An expression of one or more attributes, data types, and the values of a
    /// group.
    other_attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The name of the group.
    sam_account_name: []const u8,

    /// The unique security identifier (SID) of the group.
    sid: ?[]const u8 = null,

    pub const json_field_names = .{
        .distinguished_name = "DistinguishedName",
        .group_scope = "GroupScope",
        .group_type = "GroupType",
        .other_attributes = "OtherAttributes",
        .sam_account_name = "SAMAccountName",
        .sid = "SID",
    };
};
