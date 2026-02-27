/// MediaPackage Output Destination Settings
pub const MediaPackageOutputDestinationSettings = struct {
    /// Endpoint 1 or 2 of the channel in MediaPackageV2. Only use if you are
    /// sending CMAF Ingest output to a CMAF ingest endpoint on a MediaPackage
    /// channel that uses MediaPackage v2.
    channel_endpoint_id: ?[]const u8,

    /// Name of the channel group in MediaPackageV2. Only use if you are sending
    /// CMAF Ingest output to a CMAF ingest endpoint on a MediaPackage channel that
    /// uses MediaPackage v2.
    channel_group: ?[]const u8,

    /// ID of the channel in MediaPackage that is the destination for this output
    /// group. You do not need to specify the individual inputs in MediaPackage;
    /// MediaLive will handle the connection of the two MediaLive pipelines to the
    /// two MediaPackage inputs. The MediaPackage channel and MediaLive channel must
    /// be in the same region.
    channel_id: ?[]const u8,

    /// Name of the channel in MediaPackageV2. Only use if you are sending CMAF
    /// Ingest output to a CMAF ingest endpoint on a MediaPackage channel that uses
    /// MediaPackage v2.
    channel_name: ?[]const u8,

    /// Region the channel group and channel are located in for MediaPackageV2. Only
    /// use if you are sending CMAF Ingest output to a CMAF ingest endpoint on a
    /// MediaPackage channel that uses MediaPackage v2.
    media_package_region_name: ?[]const u8,

    pub const json_field_names = .{
        .channel_endpoint_id = "ChannelEndpointId",
        .channel_group = "ChannelGroup",
        .channel_id = "ChannelId",
        .channel_name = "ChannelName",
        .media_package_region_name = "MediaPackageRegionName",
    };
};
