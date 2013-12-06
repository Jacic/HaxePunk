﻿package com.haxepunk.tweens.misc;

import com.haxepunk.Tween;
import com.haxepunk.utils.Ease;

/**
 * Tweens a numeric public property of an Object.
 */
class VarTween extends Tween
{
	/**
	 * Constructor.
	 * @param	complete	Optional completion callback.
	 * @param	type		Tween type.
	 */
	public function new(?complete:CompleteCallback, ?type:TweenType)
	{
		super(0, type, complete);
	}

	/**
	 * Tweens a numeric public property.
	 * @param	object		The object containing the property.
	 * @param	property	The name of the property (eg. "x").
	 * @param	to			Value to tween to.
	 * @param	duration	Duration of the tween.
	 * @param	ease		Optional easer function.
	 */
	public function tween(object:Dynamic, property:String, to:Float, duration:Float, ease:EaseFunction = null)
	{
		_object = object;
		_ease = ease;

		// Check to make sure we have valid parameters
		if (!Reflect.isObject(object))
			HXP.throwError("A valid object was not passed.");

		_property = property;
		var a:Float = Reflect.getProperty(_object, property);

		// Check if the variable is a number
		if (Math.isNaN(a))
		{
			HXP.throwError("The property \"" + property + "\" is not numeric.");
		}

		_start = a;
		_range = to - _start;
		_target = duration;
		start();
	}

	/** @private Updates the Tween. */
	override public function update()
	{
		super.update();
		Reflect.setProperty(_object, _property, _start + _range * _t);
	}

	// Tween information.
	private var _object:Dynamic;
	private var _property:String;
	private var _start:Float;
	private var _range:Float;
}
