// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from packets.djinni

#import <Foundation/Foundation.h>

/**
 * \if IOS_ONLY
 * \file
 * \endif
 * Represents the data mapping in a UltraViolet data packet<br>
 *
 * The ultra violent sensor will measure UVA and UVB wavelength. The UV index
 * is the average of UVA and UVB calculated index values from raw sensor data.
 * For more information, please see http://www.vishay.com/docs/84339/designingveml6075.pdf
 * TODO: fill in more details about this sensor.
 *
 * \sa \enumlink{MuseDataPacketType,ULTRA_VIOLET,IXNMuseDataPacketTypeUltraViolet}
 * \sa \functionlink{MuseDataPacket,getUvValue,get_uv_value}
 */
typedef NS_ENUM(NSInteger, IXNUltraViolet)
{
    IXNUltraVioletUvIndex,
    IXNUltraVioletUvA,
    IXNUltraVioletUvB,
};
