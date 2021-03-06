package expo.modules.gl.cpp.legacy;

import com.facebook.soloader.SoLoader;

// Java bindings for UEXGL.h interface
public class EXGL {
  static {
    SoLoader.loadLibrary("expo-gl-legacy");
  }

  public static native int EXGLContextCreate(long jsCtxPtr); // react-native < 0.59
  public static native int EXGLContextCreateV2(long jsCtxPtr); // react-native >= 0.59

  public static native void EXGLContextDestroy(int exglCtxId);
  public static native void EXGLContextFlush(int exglCtxId);

  public static native int EXGLContextCreateObject(int exglCtxId);
  public static native void EXGLContextDestroyObject(int exglCtxId, int exglObjId);
  public static native void EXGLContextMapObject(int exglCtxId, int exglObjId, int glObj);
  public static native int EXGLContextGetObject(int exglCtxId, int exglObjId);
  public static native void EXGLContextSetFlushMethod(int exglCtxId, Object glContext);
  public static native boolean EXGLContextNeedsRedraw(int exglCtxId);
  public static native void EXGLContextDrawEnded(int exglCtxId);
}
