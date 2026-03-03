const S3Destination = @import("s3_destination.zig").S3Destination;
const Status = @import("status.zig").Status;

/// A HarvestJob resource configuration
pub const HarvestJob = struct {
    /// The Amazon Resource Name (ARN) assigned to the HarvestJob.
    arn: ?[]const u8 = null,

    /// The ID of the Channel that the HarvestJob will harvest from.
    channel_id: ?[]const u8 = null,

    /// The date and time the HarvestJob was submitted.
    created_at: ?[]const u8 = null,

    /// The end of the time-window which will be harvested.
    end_time: ?[]const u8 = null,

    /// The ID of the HarvestJob. The ID must be unique within the region
    /// and it cannot be changed after the HarvestJob is submitted.
    id: ?[]const u8 = null,

    /// The ID of the OriginEndpoint that the HarvestJob will harvest from.
    /// This cannot be changed after the HarvestJob is submitted.
    origin_endpoint_id: ?[]const u8 = null,

    s3_destination: ?S3Destination = null,

    /// The start of the time-window which will be harvested.
    start_time: ?[]const u8 = null,

    /// The current status of the HarvestJob. Consider setting up a CloudWatch Event
    /// to listen for
    /// HarvestJobs as they succeed or fail. In the event of failure, the CloudWatch
    /// Event will
    /// include an explanation of why the HarvestJob failed.
    status: ?Status = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_id = "ChannelId",
        .created_at = "CreatedAt",
        .end_time = "EndTime",
        .id = "Id",
        .origin_endpoint_id = "OriginEndpointId",
        .s3_destination = "S3Destination",
        .start_time = "StartTime",
        .status = "Status",
    };
};
