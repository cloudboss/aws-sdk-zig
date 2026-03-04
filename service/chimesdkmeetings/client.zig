const aws = @import("aws");
const std = @import("std");

const batch_create_attendee = @import("batch_create_attendee.zig");
const batch_update_attendee_capabilities_except = @import("batch_update_attendee_capabilities_except.zig");
const create_attendee = @import("create_attendee.zig");
const create_meeting = @import("create_meeting.zig");
const create_meeting_with_attendees = @import("create_meeting_with_attendees.zig");
const delete_attendee = @import("delete_attendee.zig");
const delete_meeting = @import("delete_meeting.zig");
const get_attendee = @import("get_attendee.zig");
const get_meeting = @import("get_meeting.zig");
const list_attendees = @import("list_attendees.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_meeting_transcription = @import("start_meeting_transcription.zig");
const stop_meeting_transcription = @import("stop_meeting_transcription.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_attendee_capabilities = @import("update_attendee_capabilities.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime SDK Meetings";

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

    /// Creates up to 100 attendees for an active Amazon Chime SDK meeting. For more
    /// information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html) in
    /// the *Amazon Chime Developer Guide*.
    pub fn batchCreateAttendee(self: *Self, allocator: std.mem.Allocator, input: batch_create_attendee.BatchCreateAttendeeInput, options: CallOptions) !batch_create_attendee.BatchCreateAttendeeOutput {
        return batch_create_attendee.execute(self, allocator, input, options);
    }

    /// Updates `AttendeeCapabilities` except the capabilities listed in an
    /// `ExcludedAttendeeIds` table.
    ///
    /// You use the capabilities with a set of values that control what the
    /// capabilities can do, such as `SendReceive` data. For more information about
    /// those values, see
    /// .
    ///
    /// When using capabilities, be aware of these corner cases:
    ///
    /// * If you specify `MeetingFeatures:Video:MaxResolution:None` when you create
    ///   a meeting, all API requests
    /// that include `SendReceive`, `Send`, or `Receive` for
    /// `AttendeeCapabilities:Video` will be rejected with `ValidationError 400`.
    ///
    /// * If you specify `MeetingFeatures:Content:MaxResolution:None` when you
    ///   create a meeting, all API requests that include `SendReceive`, `Send`, or
    /// `Receive` for `AttendeeCapabilities:Content` will be rejected with
    /// `ValidationError 400`.
    ///
    /// * You can't set `content` capabilities to `SendReceive` or `Receive` unless
    ///   you also set `video` capabilities to `SendReceive`
    /// or `Receive`. If you don't set the `video` capability to receive, the
    /// response will contain an HTTP 400 Bad Request status code. However, you can
    /// set your `video` capability
    /// to receive and you set your `content` capability to not receive.
    ///
    /// * If meeting features is defined as `Video:MaxResolution:None` but
    /// `Content:MaxResolution` is defined as something other than
    /// `None` and attendee capabilities are not defined in the API
    /// request, then the default attendee video capability is set to
    /// `Receive` and attendee content capability is set to
    /// `SendReceive`. This is because content `SendReceive`
    /// requires video to be at least `Receive`.
    ///
    /// * When you change an `audio` capability from `None` or `Receive` to `Send`
    ///   or `SendReceive` ,
    /// and if the attendee left their microphone unmuted, audio will flow from the
    /// attendee to the other meeting participants.
    ///
    /// * When you change a `video` or `content` capability from `None` or `Receive`
    ///   to `Send` or `SendReceive` ,
    /// and if the attendee turned on their video or content streams, remote
    /// attendees can receive those streams, but only after media renegotiation
    /// between the client and the Amazon Chime back-end server.
    pub fn batchUpdateAttendeeCapabilitiesExcept(self: *Self, allocator: std.mem.Allocator, input: batch_update_attendee_capabilities_except.BatchUpdateAttendeeCapabilitiesExceptInput, options: CallOptions) !batch_update_attendee_capabilities_except.BatchUpdateAttendeeCapabilitiesExceptOutput {
        return batch_update_attendee_capabilities_except.execute(self, allocator, input, options);
    }

    /// Creates a new attendee for an active Amazon Chime SDK meeting. For more
    /// information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the
    /// *Amazon Chime Developer Guide*.
    pub fn createAttendee(self: *Self, allocator: std.mem.Allocator, input: create_attendee.CreateAttendeeInput, options: CallOptions) !create_attendee.CreateAttendeeOutput {
        return create_attendee.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Chime SDK meeting in the specified media Region with no
    /// initial attendees. For more information about specifying media Regions, see
    /// [Available
    /// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/sdk-available-regions) and
    /// [Using meeting
    /// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/chime-sdk-meetings-regions.html), both
    /// in the *Amazon Chime SDK Developer Guide*. For more information about the
    /// Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the
    /// *Amazon Chime SDK Developer Guide*.
    ///
    /// If you use this API in conjuction with the and APIs, and you don't specify
    /// the
    /// `MeetingFeatures.Content.MaxResolution` or
    /// `MeetingFeatures.Video.MaxResolution` parameters, the following defaults are
    /// used:
    ///
    /// * Content.MaxResolution: FHD
    ///
    /// * Video.MaxResolution: HD
    pub fn createMeeting(self: *Self, allocator: std.mem.Allocator, input: create_meeting.CreateMeetingInput, options: CallOptions) !create_meeting.CreateMeetingOutput {
        return create_meeting.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon Chime SDK meeting in the specified media Region, with
    /// attendees. For more information about specifying media Regions, see
    /// [Available
    /// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/sdk-available-regions) and
    /// [Using meeting
    /// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/chime-sdk-meetings-regions.html), both
    /// in the *Amazon Chime SDK Developer Guide*. For more information about the
    /// Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the
    /// *Amazon Chime SDK Developer Guide*.
    ///
    /// If you use this API in conjuction with the and APIs, and you don't specify
    /// the
    /// `MeetingFeatures.Content.MaxResolution` or
    /// `MeetingFeatures.Video.MaxResolution` parameters, the following defaults are
    /// used:
    ///
    /// * Content.MaxResolution: FHD
    ///
    /// * Video.MaxResolution: HD
    pub fn createMeetingWithAttendees(self: *Self, allocator: std.mem.Allocator, input: create_meeting_with_attendees.CreateMeetingWithAttendeesInput, options: CallOptions) !create_meeting_with_attendees.CreateMeetingWithAttendeesOutput {
        return create_meeting_with_attendees.execute(self, allocator, input, options);
    }

    /// Deletes an attendee from the specified Amazon Chime SDK meeting and deletes
    /// their
    /// `JoinToken`. Attendees are automatically deleted when a Amazon Chime SDK
    /// meeting is deleted. For more information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the *Amazon Chime Developer Guide*.
    pub fn deleteAttendee(self: *Self, allocator: std.mem.Allocator, input: delete_attendee.DeleteAttendeeInput, options: CallOptions) !delete_attendee.DeleteAttendeeOutput {
        return delete_attendee.execute(self, allocator, input, options);
    }

    /// Deletes the specified Amazon Chime SDK meeting. The operation deletes all
    /// attendees, disconnects all clients, and prevents new clients from
    /// joining the meeting. For more information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html) in
    /// the
    /// *Amazon Chime Developer Guide*.
    pub fn deleteMeeting(self: *Self, allocator: std.mem.Allocator, input: delete_meeting.DeleteMeetingInput, options: CallOptions) !delete_meeting.DeleteMeetingOutput {
        return delete_meeting.execute(self, allocator, input, options);
    }

    /// Gets the Amazon Chime SDK attendee details for a specified meeting ID and
    /// attendee ID. For more information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the *Amazon Chime Developer Guide*.
    pub fn getAttendee(self: *Self, allocator: std.mem.Allocator, input: get_attendee.GetAttendeeInput, options: CallOptions) !get_attendee.GetAttendeeOutput {
        return get_attendee.execute(self, allocator, input, options);
    }

    /// Gets the Amazon Chime SDK meeting details for the specified meeting ID. For
    /// more information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the *Amazon Chime Developer Guide*.
    pub fn getMeeting(self: *Self, allocator: std.mem.Allocator, input: get_meeting.GetMeetingInput, options: CallOptions) !get_meeting.GetMeetingOutput {
        return get_meeting.execute(self, allocator, input, options);
    }

    /// Lists the attendees for the specified Amazon Chime SDK meeting. For more
    /// information about the Amazon Chime SDK, see
    /// [Using the Amazon Chime
    /// SDK](https://docs.aws.amazon.com/chime-sdk/latest/dg/meetings-sdk.html)
    /// in the *Amazon Chime Developer Guide*.
    pub fn listAttendees(self: *Self, allocator: std.mem.Allocator, input: list_attendees.ListAttendeesInput, options: CallOptions) !list_attendees.ListAttendeesOutput {
        return list_attendees.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags available for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts transcription for the specified `meetingId`. For more information,
    /// refer to [
    /// Using Amazon Chime SDK live transcription
    /// ](https://docs.aws.amazon.com/chime-sdk/latest/dg/meeting-transcription.html) in the *Amazon Chime SDK Developer Guide*.
    ///
    /// If you specify an invalid configuration, a `TranscriptFailed` event will be
    /// sent with the contents of the `BadRequestException` generated by Amazon
    /// Transcribe.
    /// For more information on each parameter and which combinations are valid,
    /// refer to the
    /// [StartStreamTranscription](https://docs.aws.amazon.com/transcribe/latest/APIReference/API_streaming_StartStreamTranscription.html) API in the
    /// *Amazon Transcribe Developer Guide*.
    ///
    /// By default, Amazon Transcribe may use and store audio content processed by
    /// the service to develop and improve Amazon Web Services AI/ML services as
    /// further described in section 50 of the [Amazon Web Services Service
    /// Terms](https://aws.amazon.com/service-terms/). Using Amazon Transcribe
    /// may be subject to federal and state laws or regulations regarding the
    /// recording or interception of electronic communications. It is your and your
    /// end users’
    /// responsibility to comply with all applicable laws regarding the recording,
    /// including properly notifying all participants in a recorded session or
    /// communication
    /// that the session or communication is being recorded, and obtaining all
    /// necessary consents. You can opt out from Amazon Web Services using audio
    /// content to develop and
    /// improve AWS AI/ML services by configuring an AI services opt out policy
    /// using Amazon Web Services Organizations.
    pub fn startMeetingTranscription(self: *Self, allocator: std.mem.Allocator, input: start_meeting_transcription.StartMeetingTranscriptionInput, options: CallOptions) !start_meeting_transcription.StartMeetingTranscriptionOutput {
        return start_meeting_transcription.execute(self, allocator, input, options);
    }

    /// Stops transcription for the specified `meetingId`. For more information,
    /// refer to [
    /// Using Amazon Chime SDK live transcription
    /// ](https://docs.aws.amazon.com/chime-sdk/latest/dg/meeting-transcription.html) in the *Amazon Chime SDK Developer Guide*.
    ///
    /// By default, Amazon Transcribe may use and store audio content processed by
    /// the service to develop and improve Amazon Web Services AI/ML services as
    /// further described in section 50 of the [Amazon Web Services Service
    /// Terms](https://aws.amazon.com/service-terms/). Using Amazon Transcribe
    /// may be subject to federal and state laws or regulations regarding the
    /// recording or interception of electronic communications. It is your and your
    /// end users’
    /// responsibility to comply with all applicable laws regarding the recording,
    /// including properly notifying all participants in a recorded session or
    /// communication
    /// that the session or communication is being recorded, and obtaining all
    /// necessary consents. You can opt out from Amazon Web Services using audio
    /// content to develop and
    /// improve Amazon Web Services AI/ML services by configuring an AI services opt
    /// out policy using Amazon Web Services Organizations.
    pub fn stopMeetingTranscription(self: *Self, allocator: std.mem.Allocator, input: stop_meeting_transcription.StopMeetingTranscriptionInput, options: CallOptions) !stop_meeting_transcription.StopMeetingTranscriptionOutput {
        return stop_meeting_transcription.execute(self, allocator, input, options);
    }

    /// The resource that supports tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resources. When you specify a
    /// tag key, the action removes both that key and its associated value. The
    /// operation succeeds even if you
    /// attempt to remove tags from a resource that were already removed. Note the
    /// following:
    ///
    /// * To remove tags from a resource, you need the necessary permissions for the
    ///   service that the resource belongs to as well as permissions for removing
    ///   tags. For more information,
    /// see the documentation for the service whose resource you want to untag.
    ///
    /// * You can only tag resources that are located in the specified Amazon Web
    ///   Services Region for the calling Amazon Web Services account.
    ///
    /// **Minimum permissions**
    ///
    /// In addition to the `tag:UntagResources` permission required by this
    /// operation, you must also have the remove tags permission defined by the
    /// service that created the resource.
    /// For example, to remove the tags from an Amazon EC2 instance using the
    /// `UntagResources` operation, you must have both of the following permissions:
    ///
    /// `tag:UntagResource`
    ///
    /// `ChimeSDKMeetings:DeleteTags`
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// The capabilities that you want to update.
    ///
    /// You use the capabilities with a set of values that control what the
    /// capabilities can do, such as `SendReceive` data. For more information about
    /// those values, see
    /// .
    ///
    /// When using capabilities, be aware of these corner cases:
    ///
    /// * If you specify `MeetingFeatures:Video:MaxResolution:None` when you create
    ///   a meeting, all API requests
    /// that include `SendReceive`, `Send`, or `Receive` for
    /// `AttendeeCapabilities:Video` will be rejected with `ValidationError 400`.
    ///
    /// * If you specify `MeetingFeatures:Content:MaxResolution:None` when you
    ///   create a meeting, all API requests that include `SendReceive`, `Send`, or
    /// `Receive` for `AttendeeCapabilities:Content` will be rejected with
    /// `ValidationError 400`.
    ///
    /// * You can't set `content` capabilities to `SendReceive` or `Receive` unless
    ///   you also set `video` capabilities to `SendReceive`
    /// or `Receive`. If you don't set the `video` capability to receive, the
    /// response will contain an HTTP 400 Bad Request status code. However, you can
    /// set your `video` capability
    /// to receive and you set your `content` capability to not receive.
    ///
    /// * If meeting features is defined as `Video:MaxResolution:None` but
    /// `Content:MaxResolution` is defined as something other than
    /// `None` and attendee capabilities are not defined in the API
    /// request, then the default attendee video capability is set to
    /// `Receive` and attendee content capability is set to
    /// `SendReceive`. This is because content `SendReceive`
    /// requires video to be at least `Receive`.
    ///
    /// * When you change an `audio` capability from `None` or `Receive` to `Send`
    ///   or `SendReceive` ,
    /// and if the attendee left their microphone unmuted, audio will flow from the
    /// attendee to the other meeting participants.
    ///
    /// * When you change a `video` or `content` capability from `None` or `Receive`
    ///   to `Send` or `SendReceive` ,
    /// and if the attendee turned on their video or content streams, remote
    /// attendees can receive those streams, but only after media renegotiation
    /// between the client and the Amazon Chime back-end server.
    pub fn updateAttendeeCapabilities(self: *Self, allocator: std.mem.Allocator, input: update_attendee_capabilities.UpdateAttendeeCapabilitiesInput, options: CallOptions) !update_attendee_capabilities.UpdateAttendeeCapabilitiesOutput {
        return update_attendee_capabilities.execute(self, allocator, input, options);
    }

    pub fn listAttendeesPaginator(self: *Self, params: list_attendees.ListAttendeesInput) paginator.ListAttendeesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
