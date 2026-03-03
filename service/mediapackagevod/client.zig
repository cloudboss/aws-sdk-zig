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
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Changes the packaging group's properities to configure log subscription
    pub fn configureLogs(self: *Self, allocator: std.mem.Allocator, input: configure_logs.ConfigureLogsInput, options: configure_logs.Options) !configure_logs.ConfigureLogsOutput {
        return configure_logs.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD Asset resource.
    pub fn createAsset(self: *Self, allocator: std.mem.Allocator, input: create_asset.CreateAssetInput, options: create_asset.Options) !create_asset.CreateAssetOutput {
        return create_asset.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD PackagingConfiguration resource.
    pub fn createPackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_packaging_configuration.CreatePackagingConfigurationInput, options: create_packaging_configuration.Options) !create_packaging_configuration.CreatePackagingConfigurationOutput {
        return create_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new MediaPackage VOD PackagingGroup resource.
    pub fn createPackagingGroup(self: *Self, allocator: std.mem.Allocator, input: create_packaging_group.CreatePackagingGroupInput, options: create_packaging_group.Options) !create_packaging_group.CreatePackagingGroupOutput {
        return create_packaging_group.execute(self, allocator, input, options);
    }

    /// Deletes an existing MediaPackage VOD Asset resource.
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: delete_asset.Options) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// Deletes a MediaPackage VOD PackagingConfiguration resource.
    pub fn deletePackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_packaging_configuration.DeletePackagingConfigurationInput, options: delete_packaging_configuration.Options) !delete_packaging_configuration.DeletePackagingConfigurationOutput {
        return delete_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a MediaPackage VOD PackagingGroup resource.
    pub fn deletePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: delete_packaging_group.DeletePackagingGroupInput, options: delete_packaging_group.Options) !delete_packaging_group.DeletePackagingGroupOutput {
        return delete_packaging_group.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD Asset resource.
    pub fn describeAsset(self: *Self, allocator: std.mem.Allocator, input: describe_asset.DescribeAssetInput, options: describe_asset.Options) !describe_asset.DescribeAssetOutput {
        return describe_asset.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD PackagingConfiguration resource.
    pub fn describePackagingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_packaging_configuration.DescribePackagingConfigurationInput, options: describe_packaging_configuration.Options) !describe_packaging_configuration.DescribePackagingConfigurationOutput {
        return describe_packaging_configuration.execute(self, allocator, input, options);
    }

    /// Returns a description of a MediaPackage VOD PackagingGroup resource.
    pub fn describePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: describe_packaging_group.DescribePackagingGroupInput, options: describe_packaging_group.Options) !describe_packaging_group.DescribePackagingGroupOutput {
        return describe_packaging_group.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD Asset resources.
    pub fn listAssets(self: *Self, allocator: std.mem.Allocator, input: list_assets.ListAssetsInput, options: list_assets.Options) !list_assets.ListAssetsOutput {
        return list_assets.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD PackagingConfiguration resources.
    pub fn listPackagingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_packaging_configurations.ListPackagingConfigurationsInput, options: list_packaging_configurations.Options) !list_packaging_configurations.ListPackagingConfigurationsOutput {
        return list_packaging_configurations.execute(self, allocator, input, options);
    }

    /// Returns a collection of MediaPackage VOD PackagingGroup resources.
    pub fn listPackagingGroups(self: *Self, allocator: std.mem.Allocator, input: list_packaging_groups.ListPackagingGroupsInput, options: list_packaging_groups.Options) !list_packaging_groups.ListPackagingGroupsOutput {
        return list_packaging_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags assigned to the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified resource. You can specify one or more tags to
    /// add.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource. You can specify one or more tags
    /// to remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specific packaging group. You can't change the id attribute or any
    /// other system-generated attributes.
    pub fn updatePackagingGroup(self: *Self, allocator: std.mem.Allocator, input: update_packaging_group.UpdatePackagingGroupInput, options: update_packaging_group.Options) !update_packaging_group.UpdatePackagingGroupOutput {
        return update_packaging_group.execute(self, allocator, input, options);
    }

    pub fn listAssetsPaginator(self: *Self, params: list_assets.ListAssetsInput) paginator.ListAssetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagingConfigurationsPaginator(self: *Self, params: list_packaging_configurations.ListPackagingConfigurationsInput) paginator.ListPackagingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagingGroupsPaginator(self: *Self, params: list_packaging_groups.ListPackagingGroupsInput) paginator.ListPackagingGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
