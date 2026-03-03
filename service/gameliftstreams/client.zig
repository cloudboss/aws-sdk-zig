const aws = @import("aws");
const std = @import("std");

const add_stream_group_locations = @import("add_stream_group_locations.zig");
const associate_applications = @import("associate_applications.zig");
const create_application = @import("create_application.zig");
const create_stream_group = @import("create_stream_group.zig");
const create_stream_session_connection = @import("create_stream_session_connection.zig");
const delete_application = @import("delete_application.zig");
const delete_stream_group = @import("delete_stream_group.zig");
const disassociate_applications = @import("disassociate_applications.zig");
const export_stream_session_files = @import("export_stream_session_files.zig");
const get_application = @import("get_application.zig");
const get_stream_group = @import("get_stream_group.zig");
const get_stream_session = @import("get_stream_session.zig");
const list_applications = @import("list_applications.zig");
const list_stream_groups = @import("list_stream_groups.zig");
const list_stream_sessions = @import("list_stream_sessions.zig");
const list_stream_sessions_by_account = @import("list_stream_sessions_by_account.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const remove_stream_group_locations = @import("remove_stream_group_locations.zig");
const start_stream_session = @import("start_stream_session.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_stream_session = @import("terminate_stream_session.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_stream_group = @import("update_stream_group.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "GameLiftStreams";

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

    /// Add locations that can host stream sessions. To add a location, the stream
    /// group must be in `ACTIVE` status. You configure locations and their
    /// corresponding capacity for each stream group. Creating a stream group in a
    /// location that's nearest to your end users can help minimize latency and
    /// improve quality.
    ///
    /// This operation provisions stream capacity at the specified locations. By
    /// default, all locations have 1 or 2 capacity, depending on the stream class
    /// option: 2 for 'High' and 1 for 'Ultra' and 'Win2022'. This operation also
    /// copies the content files of all associated applications to an internal S3
    /// bucket at each location. This allows Amazon GameLift Streams to host
    /// performant stream sessions.
    pub fn addStreamGroupLocations(self: *Self, allocator: std.mem.Allocator, input: add_stream_group_locations.AddStreamGroupLocationsInput, options: CallOptions) !add_stream_group_locations.AddStreamGroupLocationsOutput {
        return add_stream_group_locations.execute(self, allocator, input, options);
    }

    /// When you associate, or link, an application with a stream group, then Amazon
    /// GameLift Streams can launch the application using the stream group's
    /// allocated compute resources. The stream group must be in `ACTIVE` status.
    /// You can reverse this action by using
    /// [DisassociateApplications](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_DisassociateApplications.html).
    ///
    /// If a stream group does not already have a linked application, Amazon
    /// GameLift Streams will automatically assign the first application provided in
    /// `ApplicationIdentifiers` as the default.
    pub fn associateApplications(self: *Self, allocator: std.mem.Allocator, input: associate_applications.AssociateApplicationsInput, options: CallOptions) !associate_applications.AssociateApplicationsOutput {
        return associate_applications.execute(self, allocator, input, options);
    }

    /// Creates an application resource in Amazon GameLift Streams, which specifies
    /// the application content you want to stream, such as a game build or other
    /// software, and configures the settings to run it.
    ///
    /// Before you create an application, upload your application content files to
    /// an Amazon Simple Storage Service (Amazon S3) bucket. For more information,
    /// see **Getting Started** in the Amazon GameLift Streams Developer Guide.
    ///
    /// Make sure that your files in the Amazon S3 bucket are the correct version
    /// you want to use. If you change the files at a later time, you will need to
    /// create a new Amazon GameLift Streams application.
    ///
    /// If the request is successful, Amazon GameLift Streams begins to create an
    /// application and sets the status to `INITIALIZED`. When an application
    /// reaches `READY` status, you can use the application to set up stream groups
    /// and start streams. To track application status, call
    /// [GetApplication](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetApplication.html).
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Stream groups manage how Amazon GameLift Streams allocates resources and
    /// handles concurrent streams, allowing you to effectively manage capacity and
    /// costs. Within a stream group, you specify an application to stream,
    /// streaming locations and their capacity, and the stream class you want to use
    /// when streaming applications to your end-users. A stream class defines the
    /// hardware configuration of the compute resources that Amazon GameLift Streams
    /// will use when streaming, such as the CPU, GPU, and memory.
    ///
    /// Stream capacity represents the number of concurrent streams that can be
    /// active at a time. You set stream capacity per location, per stream group.
    /// The following capacity settings are available:
    ///
    /// * **Always-on capacity**: This setting, if non-zero, indicates minimum
    ///   streaming capacity which is allocated to you and is never released back to
    ///   the service. You pay for this base level of capacity at all times, whether
    ///   used or idle.
    /// * **Maximum capacity**: This indicates the maximum capacity that the service
    ///   can allocate for you. Newly created streams may take a few minutes to
    ///   start. Capacity is released back to the service when idle. You pay for
    ///   capacity that is allocated to you until it is released.
    /// * **Target-idle capacity**: This indicates idle capacity which the service
    ///   pre-allocates and holds for you in anticipation of future activity. This
    ///   helps to insulate your users from capacity-allocation delays. You pay for
    ///   capacity which is held in this intentional idle state.
    ///
    /// Values for capacity must be whole number multiples of the tenancy value of
    /// the stream group's stream class.
    ///
    /// To adjust the capacity of any `ACTIVE` stream group, call
    /// [UpdateStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_UpdateStreamGroup.html).
    ///
    /// If the `CreateStreamGroup` request is successful, Amazon GameLift Streams
    /// assigns a unique ID to the stream group resource and sets the status to
    /// `ACTIVATING`. It can take a few minutes for Amazon GameLift Streams to
    /// finish creating the stream group while it searches for unallocated compute
    /// resources and provisions them. When complete, the stream group status will
    /// be `ACTIVE` and you can start stream sessions by using
    /// [StartStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_StartStreamSession.html). To check the stream group's status, call [GetStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamGroup.html).
    ///
    /// Stream groups should be recreated every 3-4 weeks to pick up important
    /// service updates and fixes. Stream groups that are older than 180 days can no
    /// longer be updated with new application associations. Stream groups expire
    /// when they are 365 days old, at which point they can no longer stream
    /// sessions. The exact expiration date is indicated by the date value in the
    /// `ExpiresAt` field.
    pub fn createStreamGroup(self: *Self, allocator: std.mem.Allocator, input: create_stream_group.CreateStreamGroupInput, options: CallOptions) !create_stream_group.CreateStreamGroupOutput {
        return create_stream_group.execute(self, allocator, input, options);
    }

    /// Enables clients to reconnect to a stream session while preserving all
    /// session state and data in the disconnected session. This reconnection
    /// process can be initiated when a stream session is in either
    /// `PENDING_CLIENT_RECONNECTION` or `ACTIVE` status. The process works as
    /// follows:
    ///
    /// * Initial disconnect:
    ///
    /// * When a client disconnects or loses connection, the stream session
    ///   transitions from `CONNECTED` to `PENDING_CLIENT_RECONNECTION`
    ///
    /// * Reconnection time window:
    ///
    /// * Clients have `ConnectionTimeoutSeconds` (defined in
    ///   [StartStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_StartStreamSession.html)) to reconnect before session termination
    /// * Your backend server must call **CreateStreamSessionConnection** to
    ///   initiate reconnection
    /// * Session transitions to `RECONNECTING` status
    ///
    /// * Reconnection completion:
    ///
    /// * On successful **CreateStreamSessionConnection**, session status changes to
    ///   `ACTIVE`
    /// * Provide the new connection information to the requesting client
    /// * Client must establish connection within `ConnectionTimeoutSeconds`
    /// * Session terminates automatically if client fails to connect in time
    ///
    /// For more information about the stream session lifecycle, see [Stream
    /// sessions](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/stream-sessions.html) in the *Amazon GameLift Streams Developer Guide*.
    ///
    /// To begin re-connecting to an existing stream session, specify the stream
    /// group ID and stream session ID that you want to reconnect to, and the signal
    /// request to use with the stream.
    pub fn createStreamSessionConnection(self: *Self, allocator: std.mem.Allocator, input: create_stream_session_connection.CreateStreamSessionConnectionInput, options: CallOptions) !create_stream_session_connection.CreateStreamSessionConnectionOutput {
        return create_stream_session_connection.execute(self, allocator, input, options);
    }

    /// Permanently deletes an Amazon GameLift Streams application resource. This
    /// also deletes the application content files stored with Amazon GameLift
    /// Streams. However, this does not delete the original files that you uploaded
    /// to your Amazon S3 bucket; you can delete these any time after Amazon
    /// GameLift Streams creates an application, which is the only time Amazon
    /// GameLift Streams accesses your Amazon S3 bucket.
    ///
    /// You can only delete an application that meets the following conditions:
    ///
    /// * The application is in `READY` or `ERROR` status. You cannot delete an
    ///   application that's in `PROCESSING` or `INITIALIZED` status.
    /// * The application is not the default application of any stream groups. You
    ///   must first delete the stream group by using
    ///   [DeleteStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_DeleteStreamGroup.html).
    /// * The application is not linked to any stream groups. You must first unlink
    ///   the stream group by using
    ///   [DisassociateApplications](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_DisassociateApplications.html).
    /// * An application is not streaming in any ongoing stream session. You must
    ///   wait until the client ends the stream session or call
    ///   [TerminateStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_TerminateStreamSession.html) to end the stream.
    ///
    /// If any active stream groups exist for this application, this request returns
    /// a `ValidationException`.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Permanently deletes all compute resources and information related to a
    /// stream group. To delete a stream group, specify the unique stream group
    /// identifier. During the deletion process, the stream group's status is
    /// `DELETING`. This operation stops streams in progress and prevents new
    /// streams from starting. As a best practice, before deleting the stream group,
    /// call
    /// [ListStreamSessions](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_ListStreamSessions.html) to check for streams in progress and take action to stop them. When you delete a stream group, any application associations referring to that stream group are automatically removed.
    pub fn deleteStreamGroup(self: *Self, allocator: std.mem.Allocator, input: delete_stream_group.DeleteStreamGroupInput, options: CallOptions) !delete_stream_group.DeleteStreamGroupOutput {
        return delete_stream_group.execute(self, allocator, input, options);
    }

    /// When you disassociate, or unlink, an application from a stream group, you
    /// can no longer stream this application by using that stream group's allocated
    /// compute resources. Any streams in process will continue until they
    /// terminate, which helps avoid interrupting an end-user's stream. Amazon
    /// GameLift Streams will not initiate new streams in the stream group using the
    /// disassociated application. The disassociate action does not affect the
    /// stream capacity of a stream group. To disassociate an application, the
    /// stream group must be in `ACTIVE` status.
    ///
    /// If you disassociate the default application, Amazon GameLift Streams will
    /// automatically choose a new default application from the remaining associated
    /// applications. To change which application is the default application, call
    /// [UpdateStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_UpdateStreamGroup.html) and specify a new `DefaultApplicationIdentifier`.
    pub fn disassociateApplications(self: *Self, allocator: std.mem.Allocator, input: disassociate_applications.DisassociateApplicationsInput, options: CallOptions) !disassociate_applications.DisassociateApplicationsOutput {
        return disassociate_applications.execute(self, allocator, input, options);
    }

    /// Export the files that your application modifies or generates in a stream
    /// session, which can help you debug or verify your application. When your
    /// application runs, it generates output files such as logs, diagnostic
    /// information, crash dumps, save files, user data, screenshots, and so on. The
    /// files can be defined by the engine or frameworks that your application uses,
    /// or information that you've programmed your application to output.
    ///
    /// You can only call this action on a stream session that is in progress,
    /// specifically in one of the following statuses `ACTIVE`, `CONNECTED`,
    /// `PENDING_CLIENT_RECONNECTION`, and `RECONNECTING`. You must provide an
    /// Amazon Simple Storage Service (Amazon S3) bucket to store the files in. When
    /// the session ends, Amazon GameLift Streams produces a compressed folder that
    /// contains all of the files and directories that were modified or created by
    /// the application during the stream session. AWS uses your security
    /// credentials to authenticate and authorize access to your Amazon S3 bucket.
    ///
    /// Amazon GameLift Streams collects the following generated and modified files.
    /// Find them in the corresponding folders in the `.zip` archive.
    ///
    /// * `application/`: The folder where your application or game is stored.
    ///
    /// * `profile/`: The user profile folder.
    /// * `temp/`: The system temp folder.
    ///
    /// To verify the status of the exported files, use GetStreamSession.
    ///
    /// To delete the files, delete the object in the S3 bucket.
    pub fn exportStreamSessionFiles(self: *Self, allocator: std.mem.Allocator, input: export_stream_session_files.ExportStreamSessionFilesInput, options: CallOptions) !export_stream_session_files.ExportStreamSessionFilesOutput {
        return export_stream_session_files.execute(self, allocator, input, options);
    }

    /// Retrieves properties for an Amazon GameLift Streams application resource.
    /// Specify the ID of the application that you want to retrieve. If the
    /// operation is successful, it returns properties for the requested
    /// application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Retrieves properties for a Amazon GameLift Streams stream group resource.
    /// Specify the ID of the stream group that you want to retrieve. If the
    /// operation is successful, it returns properties for the requested stream
    /// group.
    pub fn getStreamGroup(self: *Self, allocator: std.mem.Allocator, input: get_stream_group.GetStreamGroupInput, options: CallOptions) !get_stream_group.GetStreamGroupOutput {
        return get_stream_group.execute(self, allocator, input, options);
    }

    /// Retrieves properties for a Amazon GameLift Streams stream session resource.
    /// Specify the Amazon Resource Name (ARN) of the stream session that you want
    /// to retrieve and its stream group ARN. If the operation is successful, it
    /// returns properties for the requested resource.
    pub fn getStreamSession(self: *Self, allocator: std.mem.Allocator, input: get_stream_session.GetStreamSessionInput, options: CallOptions) !get_stream_session.GetStreamSessionOutput {
        return get_stream_session.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all Amazon GameLift Streams applications that are
    /// associated with the Amazon Web Services account in use. This operation
    /// returns applications in all statuses, in no particular order. You can
    /// paginate the results as needed.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all Amazon GameLift Streams stream groups that are
    /// associated with the Amazon Web Services account in use. This operation
    /// returns stream groups in all statuses, in no particular order. You can
    /// paginate the results as needed.
    pub fn listStreamGroups(self: *Self, allocator: std.mem.Allocator, input: list_stream_groups.ListStreamGroupsInput, options: CallOptions) !list_stream_groups.ListStreamGroupsOutput {
        return list_stream_groups.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Amazon GameLift Streams stream sessions that a stream
    /// group is hosting.
    ///
    /// To retrieve stream sessions, specify the stream group, and optionally filter
    /// by stream session status. You can paginate the results as needed.
    ///
    /// This operation returns the requested stream sessions in no particular order.
    pub fn listStreamSessions(self: *Self, allocator: std.mem.Allocator, input: list_stream_sessions.ListStreamSessionsInput, options: CallOptions) !list_stream_sessions.ListStreamSessionsOutput {
        return list_stream_sessions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Amazon GameLift Streams stream sessions that this user
    /// account has access to.
    ///
    /// In the returned list of stream sessions, the `ExportFilesMetadata` property
    /// only shows the `Status` value. To get the `OutpurUri` and `StatusReason`
    /// values, use
    /// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html).
    ///
    /// We don't recommend using this operation to regularly check stream session
    /// statuses because it's costly. Instead, to check status updates for a
    /// specific stream session, use
    /// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html).
    pub fn listStreamSessionsByAccount(self: *Self, allocator: std.mem.Allocator, input: list_stream_sessions_by_account.ListStreamSessionsByAccountInput, options: CallOptions) !list_stream_sessions_by_account.ListStreamSessionsByAccountOutput {
        return list_stream_sessions_by_account.execute(self, allocator, input, options);
    }

    /// Retrieves all tags assigned to a Amazon GameLift Streams resource. To list
    /// tags for a resource, specify the ARN value for the resource.
    ///
    /// **Learn more**
    ///
    /// [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*
    ///
    /// [ Amazon Web Services Tagging
    /// Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Removes a set of remote locations from this stream group. To remove a
    /// location, the stream group must be in `ACTIVE` status. When you remove a
    /// location, Amazon GameLift Streams releases allocated compute resources in
    /// that location. Stream sessions can no longer start from removed locations in
    /// a stream group. Amazon GameLift Streams also deletes the content files of
    /// all associated applications that were in Amazon GameLift Streams's internal
    /// Amazon S3 bucket at this location.
    ///
    /// You cannot remove the Amazon Web Services Region location where you
    /// initially created this stream group, known as the primary location. However,
    /// you can set the stream capacity to zero to avoid incurring costs for
    /// allocated compute resources in that location.
    pub fn removeStreamGroupLocations(self: *Self, allocator: std.mem.Allocator, input: remove_stream_group_locations.RemoveStreamGroupLocationsInput, options: CallOptions) !remove_stream_group_locations.RemoveStreamGroupLocationsOutput {
        return remove_stream_group_locations.execute(self, allocator, input, options);
    }

    /// This action initiates a new stream session and outputs connection
    /// information that clients can use to access the stream. A stream session
    /// refers to an instance of a stream that Amazon GameLift Streams transmits
    /// from the server to the end-user. A stream session runs on a compute resource
    /// that a stream group has allocated. The start stream session process works as
    /// follows:
    ///
    /// * Prerequisites:
    ///
    /// * You must have a stream group in `ACTIVE` status
    /// * You must have idle or on-demand capacity in a stream group in the location
    ///   you want to stream from
    /// * You must have at least one application associated to the stream group (use
    ///   [AssociateApplications](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_AssociateApplications.html) if needed)
    ///
    /// * Start stream request:
    ///
    /// * Your backend server calls **StartStreamSession** to initiate connection
    /// * Amazon GameLift Streams creates the stream session resource, assigns an
    ///   Amazon Resource Name (ARN) value, and begins searching for available
    ///   stream capacity to run the stream
    /// * Session transitions to `ACTIVATING` status
    ///
    /// * Placement completion:
    ///
    /// * If Amazon GameLift Streams is successful in finding capacity for the
    ///   stream, the stream session status changes to `ACTIVE` status and
    ///   **StartStreamSession** returns stream connection information
    /// * If Amazon GameLift Streams was not successful in finding capacity within
    ///   the placement timeout period (defined according to the capacity type and
    ///   platform type), the stream session status changes to `ERROR` status and
    ///   **StartStreamSession** returns a `StatusReason` of `placementTimeout`
    ///
    /// * Connection completion:
    ///
    /// * Provide the new connection information to the requesting client
    /// * Client must establish connection within `ConnectionTimeoutSeconds`
    ///   (specified in **StartStreamSession** parameters)
    /// * Session terminates automatically if client fails to connect in time
    ///
    /// For more information about the stream session lifecycle, see [Stream
    /// sessions](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/stream-sessions.html) in the *Amazon GameLift Streams Developer Guide*.
    ///
    /// Timeouts to be aware of that affect a stream session:
    ///
    /// * **Placement timeout**: The amount of time that Amazon GameLift Streams has
    ///   to find capacity for a stream request. Placement timeout varies based on
    ///   the capacity type used to fulfill your stream request:
    ///
    /// * **Always-on capacity**: 75 seconds
    /// * **On-demand capacity**:
    ///
    /// * Linux/Proton runtimes: 90 seconds
    /// * Windows runtime: 10 minutes
    ///
    /// * **Connection timeout**: The amount of time that Amazon GameLift Streams
    ///   waits for a client to connect to a stream session in `ACTIVE` status, or
    ///   reconnect to a stream session in `PENDING_CLIENT_RECONNECTION` status, the
    ///   latter of which occurs when a client disconnects or loses connection from
    ///   a stream session. If no client connects before the timeout, Amazon
    ///   GameLift Streams terminates the stream session. This value is specified by
    ///   `ConnectionTimeoutSeconds` in the `StartStreamSession` parameters.
    /// * **Idle timeout**: A stream session will be terminated if no user input has
    ///   been received for 60 minutes.
    /// * **Maximum session length**: A stream session will be terminated after this
    ///   amount of time has elapsed since it started, regardless of any existing
    ///   client connections. This value is specified by `SessionLengthSeconds` in
    ///   the `StartStreamSession` parameters.
    ///
    /// To start a new stream session, specify a stream group ID and application ID,
    /// along with the transport protocol and signal request to use with the stream
    /// session.
    ///
    /// For stream groups that have multiple locations, provide a set of locations
    /// ordered by priority using a `Locations` parameter. Amazon GameLift Streams
    /// will start a single stream session in the next available location. An
    /// application must be finished replicating to a remote location before the
    /// remote location can host a stream.
    ///
    /// To reconnect to a stream session after a client disconnects or loses
    /// connection, use
    /// [CreateStreamSessionConnection](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_CreateStreamSessionConnection.html).
    pub fn startStreamSession(self: *Self, allocator: std.mem.Allocator, input: start_stream_session.StartStreamSessionInput, options: CallOptions) !start_stream_session.StartStreamSessionOutput {
        return start_stream_session.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags to a Amazon GameLift Streams resource. Use tags to
    /// organize Amazon Web Services resources for a range of purposes. You can
    /// assign tags to the following Amazon GameLift Streams resource types:
    ///
    /// * Application
    /// * StreamGroup
    ///
    /// **Learn more**
    ///
    /// [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*
    ///
    /// [ Amazon Web Services Tagging
    /// Strategies](http://aws.amazon.com/answers/account-management/aws-tagging-strategies/)
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Permanently terminates an active stream session. When called, the stream
    /// session status changes to `TERMINATING`. You can terminate a stream session
    /// in any status except `ACTIVATING`. If the stream session is in `ACTIVATING`
    /// status, an exception is thrown.
    pub fn terminateStreamSession(self: *Self, allocator: std.mem.Allocator, input: terminate_stream_session.TerminateStreamSessionInput, options: CallOptions) !terminate_stream_session.TerminateStreamSessionOutput {
        return terminate_stream_session.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a Amazon GameLift Streams resource. To remove
    /// tags, specify the Amazon GameLift Streams resource and a list of one or more
    /// tags to remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the mutable configuration settings for a Amazon GameLift Streams
    /// application resource. You can change the `Description`,
    /// `ApplicationLogOutputUri`, and `ApplicationLogPaths`.
    ///
    /// To update application settings, specify the application ID and provide the
    /// new values. If the operation is successful, it returns the complete updated
    /// set of settings for the application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the configuration settings for an Amazon GameLift Streams stream
    /// group resource. To update a stream group, it must be in `ACTIVE` status. You
    /// can change the description, the set of locations, and the requested capacity
    /// of a stream group per location. If you want to change the stream class,
    /// create a new stream group.
    ///
    /// Stream capacity represents the number of concurrent streams that can be
    /// active at a time. You set stream capacity per location, per stream group.
    /// The following capacity settings are available:
    ///
    /// * **Always-on capacity**: This setting, if non-zero, indicates minimum
    ///   streaming capacity which is allocated to you and is never released back to
    ///   the service. You pay for this base level of capacity at all times, whether
    ///   used or idle.
    /// * **Maximum capacity**: This indicates the maximum capacity that the service
    ///   can allocate for you. Newly created streams may take a few minutes to
    ///   start. Capacity is released back to the service when idle. You pay for
    ///   capacity that is allocated to you until it is released.
    /// * **Target-idle capacity**: This indicates idle capacity which the service
    ///   pre-allocates and holds for you in anticipation of future activity. This
    ///   helps to insulate your users from capacity-allocation delays. You pay for
    ///   capacity which is held in this intentional idle state.
    ///
    /// Values for capacity must be whole number multiples of the tenancy value of
    /// the stream group's stream class.
    ///
    /// To update a stream group, specify the stream group's Amazon Resource Name
    /// (ARN) and provide the new values. If the request is successful, Amazon
    /// GameLift Streams returns the complete updated metadata for the stream group.
    /// Expired stream groups cannot be updated.
    pub fn updateStreamGroup(self: *Self, allocator: std.mem.Allocator, input: update_stream_group.UpdateStreamGroupInput, options: CallOptions) !update_stream_group.UpdateStreamGroupOutput {
        return update_stream_group.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamGroupsPaginator(self: *Self, params: list_stream_groups.ListStreamGroupsInput) paginator.ListStreamGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamSessionsPaginator(self: *Self, params: list_stream_sessions.ListStreamSessionsInput) paginator.ListStreamSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamSessionsByAccountPaginator(self: *Self, params: list_stream_sessions_by_account.ListStreamSessionsByAccountInput) paginator.ListStreamSessionsByAccountPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilApplicationDeleted(self: *Self, params: get_application.GetApplicationInput) aws.waiter.WaiterError!void {
        var w = waiters.ApplicationDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilApplicationReady(self: *Self, params: get_application.GetApplicationInput) aws.waiter.WaiterError!void {
        var w = waiters.ApplicationReadyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamGroupActive(self: *Self, params: get_stream_group.GetStreamGroupInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamGroupActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamGroupDeleted(self: *Self, params: get_stream_group.GetStreamGroupInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamGroupDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStreamSessionActive(self: *Self, params: get_stream_session.GetStreamSessionInput) aws.waiter.WaiterError!void {
        var w = waiters.StreamSessionActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
