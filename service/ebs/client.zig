const aws = @import("aws");
const std = @import("std");

const complete_snapshot = @import("complete_snapshot.zig");
const get_snapshot_block = @import("get_snapshot_block.zig");
const list_changed_blocks = @import("list_changed_blocks.zig");
const list_snapshot_blocks = @import("list_snapshot_blocks.zig");
const put_snapshot_block = @import("put_snapshot_block.zig");
const start_snapshot = @import("start_snapshot.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EBS";

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

    /// Seals and completes the snapshot after all of the required blocks of data
    /// have been
    /// written to it. Completing the snapshot changes the status to `completed`.
    /// You
    /// cannot write new blocks to a snapshot after it has been completed.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn completeSnapshot(self: *Self, allocator: std.mem.Allocator, input: complete_snapshot.CompleteSnapshotInput, options: CallOptions) !complete_snapshot.CompleteSnapshotOutput {
        return complete_snapshot.execute(self, allocator, input, options);
    }

    /// Returns the data in a block in an Amazon Elastic Block Store snapshot.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn getSnapshotBlock(self: *Self, allocator: std.mem.Allocator, input: get_snapshot_block.GetSnapshotBlockInput, options: CallOptions) !get_snapshot_block.GetSnapshotBlockOutput {
        return get_snapshot_block.execute(self, allocator, input, options);
    }

    /// Returns information about the blocks that are different between two
    /// Amazon Elastic Block Store snapshots of the same volume/snapshot lineage.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn listChangedBlocks(self: *Self, allocator: std.mem.Allocator, input: list_changed_blocks.ListChangedBlocksInput, options: CallOptions) !list_changed_blocks.ListChangedBlocksOutput {
        return list_changed_blocks.execute(self, allocator, input, options);
    }

    /// Returns information about the blocks in an Amazon Elastic Block Store
    /// snapshot.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn listSnapshotBlocks(self: *Self, allocator: std.mem.Allocator, input: list_snapshot_blocks.ListSnapshotBlocksInput, options: CallOptions) !list_snapshot_blocks.ListSnapshotBlocksOutput {
        return list_snapshot_blocks.execute(self, allocator, input, options);
    }

    /// Writes a block of data to a snapshot. If the specified block contains
    /// data, the existing data is overwritten. The target snapshot must be in the
    /// `pending` state.
    ///
    /// Data written to a snapshot must be aligned with 512-KiB sectors.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn putSnapshotBlock(self: *Self, allocator: std.mem.Allocator, input: put_snapshot_block.PutSnapshotBlockInput, options: CallOptions) !put_snapshot_block.PutSnapshotBlockOutput {
        return put_snapshot_block.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon EBS snapshot. The new snapshot enters the `pending`
    /// state
    /// after the request completes.
    ///
    /// After creating the snapshot, use [
    /// PutSnapshotBlock](https://docs.aws.amazon.com/ebs/latest/APIReference/API_PutSnapshotBlock.html) to
    /// write blocks of data to the snapshot.
    ///
    /// You should always retry requests that receive server (`5xx`)
    /// error responses, and `ThrottlingException` and `RequestThrottledException`
    /// client error responses. For more information see [Error
    /// retries](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/error-retries.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    pub fn startSnapshot(self: *Self, allocator: std.mem.Allocator, input: start_snapshot.StartSnapshotInput, options: CallOptions) !start_snapshot.StartSnapshotOutput {
        return start_snapshot.execute(self, allocator, input, options);
    }

    pub fn listChangedBlocksPaginator(self: *Self, params: list_changed_blocks.ListChangedBlocksInput) paginator.ListChangedBlocksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSnapshotBlocksPaginator(self: *Self, params: list_snapshot_blocks.ListSnapshotBlocksInput) paginator.ListSnapshotBlocksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
