const AssociationType = @import("association_type.zig").AssociationType;
const ResaleAccountModel = @import("resale_account_model.zig").ResaleAccountModel;
const Sector = @import("sector.zig").Sector;

/// Detailed information about a partner relationship.
pub const RelationshipDetail = struct {
    /// The Amazon Resource Name (ARN) of the relationship.
    arn: ?[]const u8 = null,

    /// The AWS account ID associated in this relationship.
    associated_account_id: ?[]const u8 = null,

    /// The type of association for the relationship.
    association_type: ?AssociationType = null,

    /// The catalog identifier associated with the relationship.
    catalog: ?[]const u8 = null,

    /// The timestamp when the relationship was created.
    created_at: ?i64 = null,

    /// The display name of the relationship.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the relationship.
    id: ?[]const u8 = null,

    /// The identifier of the program management account.
    program_management_account_id: ?[]const u8 = null,

    /// The resale account model for the relationship.
    resale_account_model: ?ResaleAccountModel = null,

    /// The current revision number of the relationship.
    revision: ?[]const u8 = null,

    /// The business sector for the relationship.
    sector: ?Sector = null,

    /// The start date of the relationship.
    start_date: ?i64 = null,

    /// The timestamp when the relationship was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .associated_account_id = "associatedAccountId",
        .association_type = "associationType",
        .catalog = "catalog",
        .created_at = "createdAt",
        .display_name = "displayName",
        .id = "id",
        .program_management_account_id = "programManagementAccountId",
        .resale_account_model = "resaleAccountModel",
        .revision = "revision",
        .sector = "sector",
        .start_date = "startDate",
        .updated_at = "updatedAt",
    };
};
