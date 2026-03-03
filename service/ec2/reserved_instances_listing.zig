const InstanceCount = @import("instance_count.zig").InstanceCount;
const PriceSchedule = @import("price_schedule.zig").PriceSchedule;
const ListingStatus = @import("listing_status.zig").ListingStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a Reserved Instance listing.
pub const ReservedInstancesListing = struct {
    /// A unique, case-sensitive key supplied by the client to ensure that the
    /// request is
    /// idempotent. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The time the listing was created.
    create_date: ?i64 = null,

    /// The number of instances in this state.
    instance_counts: ?[]const InstanceCount = null,

    /// The price of the Reserved Instance listing.
    price_schedules: ?[]const PriceSchedule = null,

    /// The ID of the Reserved Instance.
    reserved_instances_id: ?[]const u8 = null,

    /// The ID of the Reserved Instance listing.
    reserved_instances_listing_id: ?[]const u8 = null,

    /// The status of the Reserved Instance listing.
    status: ?ListingStatus = null,

    /// The reason for the current status of the Reserved Instance listing. The
    /// response can be
    /// blank.
    status_message: ?[]const u8 = null,

    /// Any tags assigned to the resource.
    tags: ?[]const Tag = null,

    /// The last modified timestamp of the listing.
    update_date: ?i64 = null,
};
