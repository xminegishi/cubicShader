var FRONT = 0
var LEFT = 1
var TOP = 2
var RIGHT = 3
var BOTTOM = 4

var DIRECTION_X = 1
var DIRECTION_Y = 2
var ORIENTATION_NEGATIVE = 1
var ORIENTATION_POSITIVE = 2

var direction = 0
var orientation = 0
var angle = 0
var origin = undefined
var moving = false
var startTime
var startPoint
var thresholdVelocity = 1000
var selectedSide
var lock = false

function reset() {
    orientation = 0
    angle = 0

    frontSideRot.origin.x = 0
    frontSideRot.origin.y = frontSideContainer.height / 2

    leftSideRot.origin.x = leftSideContainer.width
    leftSideRot.origin.y = leftSideContainer.height /2

    rightSideRot.origin.x = 0
    rightSideRot.origin.y = rightSideContainer.height / 2

    topSideRot.origin.x = topSideContainer.width / 2
    topSideRot.origin.y = topSideContainer.height

    bottomSideRot.origin.x = bottomSideContainer.width / 2
    bottomSideRot.origin.y = 0

    frontSideRot.angle = 0
    leftSideRot.angle = 270
    rightSideRot.angle = 90
    topSideRot.angle = 90
    bottomSideRot.angle = 270
}

function getOrientation(delta) {
    if(delta < 0)
        return ORIENTATION_NEGATIVE
    return ORIENTATION_POSITIVE
}

function mapToOrigin(mouse) {
    return [mouse.x - container.width / 2, -mouse.y - container.height / 2]
}

function initRotation(mouse) {
    if(lock)
        return

    origin = mapToOrigin(mouse)
    startTime = new Date()
    startPoint = origin.slice()
}

function animate(mouse) {
    var fakeMouse = {"y": mouse.y, "x": mouse.x} // mouse properties are read-only
    for (var i = 0; i < 20; i++) {
        fakeMouse.y -= 1
        rotate(fakeMouse, true)
    }
}

function rotate(mouse, forced) {
    if(lock)
        return moving

    var coords = mapToOrigin(mouse)

    if(!direction) {
        var dx = Math.abs(coords[0] - origin[0])
        var dy = Math.abs(coords[1] - origin[1])

        if(Math.max(dy, dx) < 20 && !forced)
            return moving

        if(dy > dx)
            direction = DIRECTION_Y
        else
            direction = DIRECTION_X

        //rotationDirection = direction;
    }
    else {
        moving = true
        var side = frontSideContainer
        var sideRot = frontSideRot
        var nextSide, nextSideRot, a, delta

        //rotationDirection = direction;

        if(direction == DIRECTION_X) {
            delta = coords[0] - origin[0]
            a = 90 * delta / container.width

            if(!orientation) {
                orientation = getOrientation(delta)
                sideRot.axis.x = 0
                sideRot.axis.y = 1
            }

            if(orientation == 1) {
                sideRot.origin.x = side.width
                sideRot.origin.y = side.height / 2
                nextSide = rightSideContainer
                nextSideRot = rightSideRot
            }
            else {
                sideRot.origin.x = 0
                sideRot.origin.y = side.height / 2
                nextSide = leftSideContainer
                nextSideRot = leftSideRot
            }
        }
        else {
            delta = coords[1] - origin[1]
            a = 90 * delta / container.height

            if(!orientation) {
                orientation = getOrientation(delta)
                sideRot.axis.x = 1
                sideRot.axis.y = 0
            }

            if(orientation == 1) {
                sideRot.origin.x = side.width / 2
                sideRot.origin.y = 0
                nextSide = topSideContainer
                nextSideRot = topSideRot
            }
            else {
                sideRot.origin.x = side.width / 2
                sideRot.origin.y = side.height
                nextSide = bottomSideContainer
                nextSideRot = bottomSideRot
            }
        }

        origin = coords

        if(Math.abs(angle + a) >= 90)
            return moving

        angle += a

        if((orientation == 1 && angle > 0) || (orientation == 2 && angle < 0)) {
            reset()
        }
        else {
            if(direction == DIRECTION_X) {
                side.x += delta
                nextSide.x += delta
                //rotationPosition = side.x
            }
            else {
                side.y += -delta
                nextSide.y += -delta
                //rotationPosition = side.y
            }

            sideRot.angle += a
            nextSideRot.angle += a
        }
    }
    return moving
}

function finishRotation(mouse) {
    if(lock)
        return
    else
        lock = true

    var dest = mapToOrigin(mouse)
    var elapsedTime = (new Date().getTime() - startTime.getTime()) / 1000
    var deltaPos = Math.max(Math.abs(dest[0] - startPoint[0]), Math.abs(dest[1] - startPoint[1]))

    moving = false

    if(Math.abs(angle) > 45 || deltaPos / elapsedTime > thresholdVelocity) {
        if(direction == DIRECTION_X) {
            if(orientation == 1)
                return RIGHT
            else
                return LEFT
        }
        else {
            if(orientation == 1)
                return TOP
            else
                return BOTTOM
        }
    }
    else
        return FRONT
}
