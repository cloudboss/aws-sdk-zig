const aws = @import("aws");
const std = @import("std");

const configure_logs = @import("configure_logs.zig");
const create_asset = @import("create_asset.zig");
const create_packaging_configuration = @import("create_packaging_configuration.zig");
const create_packaging_group = @import("create_packaging_group.zig");
const delete_asset = @import("delete_asset.zig");
const delete_packaging_configuration = @import("delete_packaging_configuration.zig");
const delete_packaging_group = @import("delete_packaging_group.zig");
const describe_asset = @import("describe_asset.zig");
const describe_packaging_configuration = @import("describe_packaging_configuration.zig");
const describe_packaging_group = @import("describe_packaging_group.zig");
const list_assets = @import("list_assets.zig");
const list_packaging_configurations = @import("list_packaging_configurations.zig");
const list_packaging_groups = @import("list_packaging_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_packaging_group = @import("update_packaging_group.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaPackage Vod";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Changes the packaging group's properities to configure log subscription
    pub fn configureLogs(self: *Self, allocator: std.mem.Allocator, input: configure_logs.ConfigureLogsInput, options: CallOptions) !configure_logs.ConfigureLogsOutput {
        return configure_logs.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD Asset resource.
    pub fn createAsset(self: *Self, allocator: std.mem.Allocator, input: create_asset.CreateAssetInput, options: CallOptions) !create_asset.CreateAssetOutput {
        return create_asset.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD PackagingConfiguration resource.
    pub fn createPackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_packaging_configuration.CreatePackagingConfigurationInput, options: CallOptions) !create_packaging_configuration.CreatePackagingConfigurationOutput {
        return create_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD PackagingGroup resource.
    pub fn createPackagingGroup(self: *Self, allocator: std.mem.Allocator, input: create_packaging_group.CreatePackagingGroupInput, options: CallOptions) !create_packaging_group.CreatePackagingGroupOutput {
        return create_packaging_group.execute(self, allocator, input, options);
    }

    /// Deletes an existing MediaPackage VOD Asset resource.
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: CallOptions) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// Deletes a MediaPackage VOD PackagingConfiguration resource.
    pub fn deletePackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_packaging_configuration.DeletePackagingConfigurationInput, options: CallOptions) !delete_packaging_configuration.DeletePackagingConfigurationOutput {
        return delete_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a MediaPackage VOD PackagingGroup resource.
    pub fn deletePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_packaging_group.DeletePackagingGroupInput, options: CallOptions) !delete_packaging_group.DeletePackagingGroupOutput {
        return delete_packaging_group.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD Asset resource.
    pub fn describeAsset(self: *Self, allocator: std.mem.Allocator, input: describe_asset.DescribeAssetInput, options: CallOptions) !describe_asset.DescribeAssetOutput {
        return describe_asset.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD PackagingConfiguration resource.
    pub fn describePackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_packaging_configuration.DescribePackagingConfigurationInput, options: CallOptions) !describe_packaging_configuration.DescribePackagingConfigurationOutput {
        return describe_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD PackagingGroup resource.
    pub fn describePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: describe_packaging_group.DescribePackagingGroupInput, options: CallOptions) !describe_packaging_group.DescribePackagingGroupOutput {
        return describe_packaging_group.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD Asset resources.
    pub fn listAssets(self: *Self, allocator: std.mem.Allocator, input: list_assets.ListAssetsInput, options: CallOptions) !list_assets.ListAssetsOutput {
        return list_assets.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD PackagingConfiguration resources.
    pub fn listPackagingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_packaging_configurations.ListPackagingConfigurationsInput, options: CallOptions) !list_packaging_configurations.ListPackagingConfigurationsOutput {
        return list_packaging_configurations.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD PackagingGroup resources.
    pub fn listPackagingGroups(self: *Self, allocator: std.mem.Allocator, input: list_packaging_groups.ListPackagingGroupsInput, options: CallOptions) !list_packaging_groups.ListPackagingGroupsOutput {
        return list_packaging_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags assigned to the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified resource. You can specify one or more tags to
    /// add.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource. You can specify one or more tags
    /// to remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specific packaging group. You can't change the id attribute or any
    /// other system-generated attributes.
    pub fn updatePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: update_packaging_group.UpdatePackagingGroupInput, options: CallOptions) !update_packaging_group.UpdatePackagingGroupOutput {
        return update_packaging_group.execute(self, allocator, input, options);
    }

    pub fn listAssetsPaginator(self: *Self, params: list_assets.ListAssetsInput) paginator.ListAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPackagingConfigurationsPaginator(self: *Self, params: list_packaging_configurations.ListPackagingConfigurationsInput) paginator.ListPackagingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPackagingGroupsPaginator(self: *Self, params: list_packaging_groups.ListPackagingGroupsInput) paginator.ListPackagingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
