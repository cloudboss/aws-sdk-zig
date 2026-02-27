const aws = @import("aws");

const ContactStatus = @import("contact_status.zig").ContactStatus;
const EphemerisResponseData = @import("ephemeris_response_data.zig").EphemerisResponseData;
const Elevation = @import("elevation.zig").Elevation;

/// Data describing a contact.
pub const ContactData = struct {
    /// UUID of a contact.
    contact_id: ?[]const u8,

    /// Status of a contact.
    contact_status: ?ContactStatus,

    /// End time of a contact in UTC.
    end_time: ?i64,

    /// The ephemeris that determines antenna pointing for the contact.
    ephemeris: ?EphemerisResponseData,

    /// Error message of a contact.
    error_message: ?[]const u8,

    /// Name of a ground station.
    ground_station: ?[]const u8,

    /// Maximum elevation angle of a contact.
    maximum_elevation: ?Elevation,

    /// ARN of a mission profile.
    mission_profile_arn: ?[]const u8,

    /// Amount of time after a contact ends that you’d like to receive a CloudWatch
    /// event indicating the pass has finished.
    post_pass_end_time: ?i64,

    /// Amount of time prior to contact start you’d like to receive a CloudWatch
    /// event indicating an upcoming pass.
    pre_pass_start_time: ?i64,

    /// Region of a contact.
    region: ?[]const u8,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8,

    /// Start time of a contact in UTC.
    start_time: ?i64,

    /// Tags assigned to a contact.
    tags: ?[]const aws.map.StringMapEntry,

    /// Projected time in UTC your satellite will set below the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts. *This field is not present for contacts with a
    /// `SCHEDULING` or `SCHEDULED` status.*
    visibility_end_time: ?i64,

    /// Projected time in UTC your satellite will rise above the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts. *This field is not present for contacts with a
    /// `SCHEDULING` or `SCHEDULED` status.*
    visibility_start_time: ?i64,

    pub const json_field_names = .{
        .contact_id = "contactId",
        .contact_status = "contactStatus",
        .end_time = "endTime",
        .ephemeris = "ephemeris",
        .error_message = "errorMessage",
        .ground_station = "groundStation",
        .maximum_elevation = "maximumElevation",
        .mission_profile_arn = "missionProfileArn",
        .post_pass_end_time = "postPassEndTime",
        .pre_pass_start_time = "prePassStartTime",
        .region = "region",
        .satellite_arn = "satelliteArn",
        .start_time = "startTime",
        .tags = "tags",
        .visibility_end_time = "visibilityEndTime",
        .visibility_start_time = "visibilityStartTime",
    };
};
