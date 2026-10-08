const PurchaseOptionAssociatedEntity = @import("purchase_option_associated_entity.zig").PurchaseOptionAssociatedEntity;
const PurchaseOptionBadge = @import("purchase_option_badge.zig").PurchaseOptionBadge;
const PurchaseOptionType = @import("purchase_option_type.zig").PurchaseOptionType;
const SellerInformation = @import("seller_information.zig").SellerInformation;

/// Summary information about a purchase option (offer or offer set) available
/// to the buyer, including the seller, badges, and associated products.
pub const PurchaseOptionSummary = struct {
    /// The products, offers, and offer sets associated with this purchase option.
    associated_entities: []const PurchaseOptionAssociatedEntity,

    /// The date and time when the purchase option became available to the buyer.
    available_from_time: ?i64 = null,

    /// Badges indicating special attributes of the purchase option, such as private
    /// pricing or future dated.
    badges: ?[]const PurchaseOptionBadge = null,

    /// The name of the catalog that the purchase option belongs to.
    catalog: []const u8,

    /// The date and time when the purchase option expires and is no longer
    /// available for procurement.
    expiration_time: ?i64 = null,

    /// The unique identifier of the purchase option.
    purchase_option_id: []const u8,

    /// The display name of the purchase option.
    purchase_option_name: ?[]const u8 = null,

    /// The type of purchase option. Values are `OFFER` for a single-product offer
    /// or `OFFERSET` for a bundled offer set.
    purchase_option_type: PurchaseOptionType,

    /// The entity responsible for selling the product under this purchase option.
    seller_of_record: SellerInformation,

    pub const json_field_names = .{
        .associated_entities = "associatedEntities",
        .available_from_time = "availableFromTime",
        .badges = "badges",
        .catalog = "catalog",
        .expiration_time = "expirationTime",
        .purchase_option_id = "purchaseOptionId",
        .purchase_option_name = "purchaseOptionName",
        .purchase_option_type = "purchaseOptionType",
        .seller_of_record = "sellerOfRecord",
    };
};
