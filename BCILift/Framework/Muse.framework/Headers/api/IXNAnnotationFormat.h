// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from muse_file.djinni

#import <Foundation/Foundation.h>

/**
 * \if IOS_ONLY
 * \file
 * \endif
 * Represents all possible data types in the annotation data. These fields correspond
 * to our %Muse protobuf schema.
 */
typedef NS_ENUM(NSInteger, IXNAnnotationFormat)
{
    /** The data is a string with no inherrent format. */
    IXNAnnotationFormatPlainString,
    /** The data is a string of JSON name, value pairs. */
    IXNAnnotationFormatJson,
    /** The data is formatted as OSC (open sound control) data. */
    IXNAnnotationFormatOsc,
};