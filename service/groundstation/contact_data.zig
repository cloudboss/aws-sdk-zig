const aws = @import("aws");

const ContactStatus = @import("contact_status.zig").ContactStatus;
const EphemerisResponseData = @import("ephemeris_response_data.zig").EphemerisResponseData;
const Elevation = @import("elevation.zig").Elevation;
const ContactVersion = @import("contact_version.zig").ContactVersion;

/// Data describing a contact.
pub const ContactData = struct {
    /// UUID of a contact.
    contact_id: ?[]const u8 = null,

    /// Status of a contact.
    contact_status: ?ContactStatus = null,

    /// End time of a contact in UTC.
    end_time: ?i64 = null,

    /// The ephemeris that determines antenna pointing for the contact.
    ephemeris: ?EphemerisResponseData = null,

    /// Error message of a contact.
    error_message: ?[]const u8 = null,

    /// Name of a ground station.
    ground_station: ?[]const u8 = null,

    /// Maximum elevation angle of a contact.
    maximum_elevation: ?Elevation = null,

    /// ARN of a mission profile.
    mission_profile_arn: ?[]const u8 = null,

    /// End time in UTC of the post-pass period, at which you receive a CloudWatch
    /// event indicating the pass has finished.
    post_pass_end_time: ?i64 = null,

    /// Start time in UTC of the pre-pass period, at which you receive a CloudWatch
    /// event indicating an upcoming pass.
    pre_pass_start_time: ?i64 = null,

    /// Region of a contact.
    region: ?[]const u8 = null,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8 = null,

    /// Start time of a contact in UTC.
    start_time: ?i64 = null,

    /// Tags assigned to a contact.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Version information for a contact.
    version: ?ContactVersion = null,

    /// Projected time in UTC your satellite will set below the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts. *This field is not present for contacts with a
    /// `SCHEDULING` or `SCHEDULED` status.*
    visibility_end_time: ?i64 = null,

    /// Projected time in UTC your satellite will rise above the [receive
    /// mask](https://docs.aws.amazon.com/ground-station/latest/ug/site-masks.html).
    /// This time is based on the satellite's current active ephemeris for future
    /// contacts and the ephemeris that was active during contact execution for
    /// completed contacts. *This field is not present for contacts with a
    /// `SCHEDULING` or `SCHEDULED` status.*
    visibility_start_time: ?i64 = null,

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
        .version = "version",
        .visibility_end_time = "visibilityEndTime",
        .visibility_start_time = "visibilityStartTime",
    };
};
